import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/resources/app_string.dart';
import '../../../../data/models/vet_response_model.dart';
import '../../../../repository/pet_home_repository.dart';

class VetSearchViewModel extends GetxController {

  final PetHomeRepository repository;

  VetSearchViewModel({required this.repository});

  RxBool hasPermission = false.obs;
  RxBool showCard = false.obs;
  RxBool showLoader = true.obs;
  GoogleMapController? googleMapController;
  Rx<LatLng>? latLng = const LatLng(29.735455, -95.540241).obs;
  RxList<Marker> allMarkers = List<Marker>.empty().obs;
  Rx<String> mapStyle = "".obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();
  RxString selectedMarkerId = "0".obs;
  BitmapDescriptor? _normalIcon;
  BitmapDescriptor? _selectedIcon;
  Timer? debounce;
  RxInt? selectedIndex;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  RxList<VetData> arrOfVets = List<VetData>.empty().obs;
  Rx<VetData> vetSelectedModel = VetData().obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    hasPermission.value = await checkPermissionStatus();
  }

  Future<bool> checkPermissionStatus() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showLoader.value = false;
      return false;
    }
    if (permission == LocationPermission.deniedForever) {
      showLoader.value = false;
      return false;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) => {
      latLng = LatLng(value.latitude, value.longitude).obs,
      print(latLng),

    })
        .catchError((e) {
      print(e);
    });
    latLng!.refresh();
    showLoader.value = false;
    rootBundle.loadString(AppString.mapStyle).then((string) {
      mapStyle.value = string;
    });

    toTheCurrentLocation(
        CameraPosition(zoom: 15, bearing: 40, target: latLng!.value));
    showLoader.value = false;

    return true;
  }

  Future<void> toTheCurrentLocation(CameraPosition point) async {
    if(googleMapController!=null) {
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(point));
    }
  }

  generateVets(VetData model) async {
    vetSelectedModel.value = model;
    _normalIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        Platform.isIOS
            ? AppImages.iosBlueMarker
            :  AppImages.blueMarker);

    _selectedIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        Platform.isIOS
            ? AppImages.iosRedMarker
            :  AppImages.redMarker);

    Rx<Marker> resultMarker = Marker(
        icon: _normalIcon!,
        consumeTapEvents: true,
        markerId: MarkerId(vetSelectedModel.value.id!.toString()),
        position: LatLng(vetSelectedModel.value.latitude!,vetSelectedModel.value.longitude!),
        onTap: () {
          if (vetSelectedModel.value.isSelected!.value) {
            vetSelectedModel.value.isSelected!.value = false;
            showCard.value = false;
            _onMarkerTapped(vetSelectedModel.value.id.toString());
          } else {
            _onMarkerTapped(vetSelectedModel.value.id.toString());
            vetSelectedModel.value.isSelected!.value = true;
            showCard.value = true;
            selectedIndex = vetSelectedModel.value.id!.obs;
            selectedIndex!.refresh();
            print("farhan");
            print(selectedIndex!.value);
          }
          allMarkers.refresh();
        }).obs;
    // Add it to Set
    allMarkers.add(resultMarker.value);

    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, bearing: 40, target: LatLng(vetSelectedModel.value.latitude!,vetSelectedModel.value.longitude!))));
  }


  void onMapCreated(controller) {
    googleMapController = controller;
    googleMapController!.setMapStyle(mapStyle.value);
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(zoom: 15, bearing: 40, target: latLng!.value)));
  }

  void _onMarkerTapped(String markerId) {
    selectedMarkerId.value = markerId;
  }

  Set<Marker> getMarkers(bool isSelect) {
    return allMarkers.map((marker) {
      if (marker.markerId.value == selectedMarkerId.value && isSelect) {
        return marker.copyWith(iconParam:_selectedIcon);
      } else {
        return marker.copyWith(iconParam:_normalIcon);
      }
    }).toSet();
  }


  Future<dynamic>  getVets(String query) async {

    isDataLoading.value =   true;
    arrOfVets.clear();
    Map<String,dynamic> map = {

      'pagination': 0,
      'search': query,
      'relations':['user_detail','user_image'],

    };

    final result = await repository.getLimitedVets(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) async {

      hasPermission.value = await checkPermissionStatus();
      arrOfVets.value = response.data;
      for(var item in arrOfVets){
        item.isSelected = false.obs;
        item.address = "".obs;

        if(item.latitude!=null) {
          getAddressFromLatLng(
              Get.context, item.latitude!, item.longitude!).then((value) {
            item.address!.value = value;
            item.address!.refresh();
          });
        }
      }


      arrOfVets.refresh();
      isDataLoading.value = false;

    });
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

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

}
