import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petsvet_connect/app/modules/pet_module/home/views/home_view.dart';
import '../../../../../../utils/Util.dart';
import '../../../../components/resources/app_string.dart';
import '../../home/view_model/home_view_model.dart';

class NoLocationViewModel extends GetxController  with WidgetsBindingObserver{
  bool isFirstTime = false;
  HomeViewModel homeViewModel = Get.find();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }


  onTapEnableLocation() async {
    _getCurrentPosition();
  }


  Future<void> _getCurrentPosition() async {
    homeViewModel.showLoader.value = true;
    final hasPermission = await _handleLocationPermission();
    homeViewModel.hasPermission.value = hasPermission;
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low).then((value) => {
      homeViewModel.latLng = LatLng(value.latitude, value.longitude).obs,
      homeViewModel.latLng!.refresh(),
    homeViewModel.showLoader.value = false,
    }).catchError((e) {
      print(e);
    });
    rootBundle.loadString(AppString.mapStyle).then((string) {
      homeViewModel.mapStyle.value = string;
    });
    homeViewModel.toTheCurrentLocation(CameraPosition(zoom: 15, bearing: 40, target: homeViewModel.latLng!.value));

  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.location.isGranted;
      if (granted) {
        homeViewModel.hasPermission.value = true;
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) async => {
          homeViewModel.latLng = LatLng(value.latitude, value.longitude).obs,
          homeViewModel.latLng!.refresh(),
          homeViewModel.getAddressFromLatLng(Get.context,value.latitude,value.longitude).then((value) {
            homeViewModel.currentAddress.value = value;
          }),
          homeViewModel.getNearByVets(),

        }).catchError((e) {
          print(e);
        });
        rootBundle.loadString(AppString.mapStyle).then((string) {
          homeViewModel.mapStyle.value = string;
        });
        homeViewModel.toTheCurrentLocation(CameraPosition(zoom: 15, bearing: 40, target: homeViewModel.latLng!.value));

      }else{
        homeViewModel.hasPermission.value = false;
        homeViewModel.showLoader.value = false;
      }
    }
  }

  Future<bool> _handleLocationPermission() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Util.showToast('Location services are disabled. Please enable the services');
      homeViewModel.hasPermission.value = false;
      homeViewModel.showLoader.value = false;
      return false;

    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Util.showToast('Location permissions are denied');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {

      if(isFirstTime==false) {
        isFirstTime=true;
        Util.showToast('Location permissions are permanently denied');
      }else {
        Geolocator.openAppSettings();
      }
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
