import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petsvet_connect/app/components/resources/app_string.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../utils/Util.dart';
import '../../../components/resources/app_images.dart';
import '../../../data/models/local_location.dart';
import '../../../repository/address_repository.dart';

class AddLocationPickerViewModel extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  RxList<Marker> allMarkers = List<Marker>.empty().obs;

  final AddressRepository repository;

  AddLocationPickerViewModel({required this.repository});

  bool isFirstTime = false;
  RxBool showCancelBtn = false.obs;
  GoogleMapController? _controller;

  final Rxn<Prediction> predication=Rxn();
  final Rxn<LocalLocation> location=Rxn();

  RxDouble currentLat = 0.0.obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxDouble currentLng = 0.0.obs;

  var data = Get.arguments;

  @override
  void onInit() {

    super.onInit();
    initCurrentLocation();
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }


  void selectLocation(LocalLocation loc){
    location.value=loc;
    moveToCameraLocation(latLng: LatLng(lat.value, lng.value));
  }


  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    setDarkModeStyle(controller);
  }

  Future<String> _loadMapDarkModeStyle() async {
    return await rootBundle.loadString(AppString.mapStyle);
  }

  Future<void> setDarkModeStyle(GoogleMapController controller) async {
    String darkModeStyle = await _loadMapDarkModeStyle();
    controller.setMapStyle(darkModeStyle);
  }

  void initCurrentLocation() async {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse ) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high).then((position) {
        print(permission);
        moveToCameraLocation(
          latLng: LatLng(position.latitude, position.longitude),
        );
        lat.value = position.latitude;
        currentLat.value = position.latitude;
        lng.value = position.longitude;
        currentLng.value = position.longitude;
        getAddressFromLatLng(Get.context,position.latitude,position.longitude).then((value) {
          selectLocation(LocalLocation(
              type: "Point",
              coordinates: [
                position.latitude,
                position.longitude
              ],
              radius: "50",
              address: value,
              city: ""
          ));
        });
      });
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Util.showToast('Location permissions are denied');

      }
    }
    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
    }
    else {
      permission = await Geolocator.requestPermission();
    }
  }

  Future<void> moveToCameraLocation({required LatLng latLng}) async {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));

    Rx<Marker> resultMarker = Marker(
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                Platform.isIOS
                    ? AppImages.iosBlueMarker
                    : AppImages.blueMarker),
            consumeTapEvents: true,
            markerId: MarkerId('1'),
            draggable: true,
            onDragEnd: ((newPosition) {
              latLng = LatLng(newPosition.latitude, newPosition.longitude);
              moveToCameraLocation(latLng: latLng);
            }),
            position: latLng,
            onTap: () {})
        .obs;

    allMarkers.add(resultMarker.value);
  }

  Future<void> toTheCurrentLocation(CameraPosition point) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(point));
    Rx<LatLng> latLng = LatLng(0.0, 0.0).obs;
    Rx<Marker> resultMarker = Marker(
            icon: await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                Platform.isIOS
                    ? AppImages.iosBlueMarker
                    : AppImages.blueMarker),
            consumeTapEvents: true,
            markerId: MarkerId('1'),
            draggable: true,
            onDragEnd: ((newPosition) {
              latLng.value = LatLng(newPosition.latitude, newPosition.longitude);
              moveToCameraLocation(latLng: LatLng(newPosition.latitude,newPosition.longitude));
            }),
            position: LatLng(currentLat.value,currentLng.value),
            onTap: () {})
        .obs;

    allMarkers.add(resultMarker.value);
  }

  Future<String> getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${Constants.mapApiKey}&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return "";
    } else return "";
  }

  Future<dynamic> addAddressAPI(LocalLocation location) async {

    Map<String,dynamic> data = {
      "latitude": lat.value,
      "longitude": lat.value,
      "address": location.address,
      "city": location.city!.isNotEmpty?location.city:"-",
    };

    final result = await repository.addAddress(data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
      Get.back(result: location);
    });
  }

}
