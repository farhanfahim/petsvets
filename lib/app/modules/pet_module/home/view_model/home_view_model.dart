import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/resources/app_string.dart';
import '../../../../data/models/vet_response_model.dart';
import '../../../../repository/pet_home_repository.dart';

class HomeViewModel extends GetxController {

  final PetHomeRepository repository;

  HomeViewModel({required this.repository});

  RxBool hasPermission = false.obs;
  RxBool showCard = false.obs;
  RxBool showLoader = true.obs;
  GoogleMapController? googleMapController;
  Rx<LatLng>? latLng = const LatLng(29.735455, -95.540241).obs;
  RxList<Marker> allMarkers = List<Marker>.empty().obs;
  Rx<String> mapStyle = "".obs;
  RxBool isMapVisible = true.obs;
  RxString selectedMarkerId = "0".obs;
  BitmapDescriptor? _normalIcon;
  BitmapDescriptor? _selectedIcon;
  RxString currentAddress = "".obs;
  RxInt? selectedIndex;
  int currentPage = 1;
  int totalPages = 0;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  RxList<VetData> arrOfNearbyVets = List<VetData>.empty().obs;
  final PagingController<int, VetData> vetListController = PagingController<int, VetData>(firstPageKey: 1);

  @override
  Future<void> onInit() async {
    super.onInit();
    vetListController.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });
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
              getAddressFromLatLng(Get.context,value.latitude,value.longitude).then((value) {
                currentAddress.value = value;
              }),
      getNearByVets(),
            })
        .catchError((e) {
      print(e);
    });
    latLng!.refresh();

    rootBundle.loadString(AppString.mapStyle).then((string) {
      mapStyle.value = string;
    });

    toTheCurrentLocation(
        CameraPosition(zoom: 15, bearing: 40, target: latLng!.value));
    showLoader.value = false;

    return true;
  }

  Future<void> toTheCurrentLocation(CameraPosition point) async {
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(point));
  }

  void onMapCreated(controller) {
    googleMapController = controller;
    googleMapController!.setMapStyle(mapStyle.value);
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, bearing: 40, target: latLng!.value)));
  }

  generateVets() async {

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

    arrOfNearbyVets.asMap().forEach((index, v) async {
      Rx<Marker> resultMarker = Marker(
          icon: _normalIcon!,
          consumeTapEvents: true,
          markerId: MarkerId(index.toString()),
          position: LatLng(v.latitude!,v.longitude!),
          onTap: () {
            if (v.isSelected!.value) {
              v.isSelected!.value = false;
              showCard.value = false;
              _onMarkerTapped(index.toString());
            } else {
              _onMarkerTapped(index.toString());
              v.isSelected!.value = true;
              showCard.value = true;
              selectedIndex = index.obs;
              selectedIndex!.refresh();
              print("farhan");
              print(selectedIndex!.value);
            }
            allMarkers.refresh();
          }).obs;
      // Add it to Set
      allMarkers.add(resultMarker.value);
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 15, bearing: 40, target: LatLng(v.latitude!,v.longitude!))));
      showLoader.value = false;
    });
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      getVets();
    } catch (error) {
      vetListController.error = error;
    }
  }

  Future<dynamic>  getVets({bool isRefresh = false}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'latitude': latLng!.value.latitude,
      'longitude':  latLng!.value.longitude,
      'relations':['user_detail','user_image'],
    };

    final result = await repository.getVets(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {

      log(response.data.toJson().toString());
      if(isRefresh) {

        if(vetListController.itemList != null) {
          vetListController.itemList!.clear();
        }
      }
      totalPages = response.data.meta!.lastPage!;

      final isNotLastPage = currentPage + 1 <= totalPages;

      if (!isNotLastPage) {

        vetListController.appendLastPage(response.data.data!);
        for(var item in vetListController.itemList!){
            item.isSelected = false.obs;
            item.address = "".obs;
            getAddressFromLatLng(
                Get.context, item.latitude!, item.longitude!).then((value) {
              item.address!.value = value;
              item.address!.refresh();
            });
        }

      } else {

        currentPage = currentPage + 1;

        vetListController.appendPage(response.data.data!, currentPage);
        for(var item in vetListController.itemList!){
          item.isSelected = false.obs;
          if(item.latitude!=null) {
            item.address = "".obs;
            getAddressFromLatLng(
                Get.context, item.latitude!, item.longitude!).then((value) {
              item.address!.value = value;
              item.address!.refresh();
            });
          }
        }
      }

      isDataLoading.value = false;

    });
  }

  Future<dynamic>  getNearByVets() async {

    showLoader.value =  true;

    var map = {
      'pagination': 0,
      'latitude': latLng!.value.latitude,
      'longitude':  latLng!.value.longitude,
      'relations':['user_detail','user_image'],
    };

    final result = await repository.getNearbyVets(map);
    result.fold((l) {

      showLoader.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {

      arrOfNearbyVets.value = response.data;
      for(var item in arrOfNearbyVets){
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


      print("farhan");
      print(arrOfNearbyVets.length);
      arrOfNearbyVets.refresh();
      showLoader.value = false;
      generateVets();
    });
  }

  void refreshData() {
    isError.value = false;
    errorMessage.value = '';
    currentPage = 1;

    getVets(isRefresh: true);
  }
}
