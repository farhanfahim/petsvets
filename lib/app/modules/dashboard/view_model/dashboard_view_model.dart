import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
 import 'package:petsvet_connect/app/modules/calender/views/calender_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/my_bookings/views/my_bookings_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_home/views/vet_home_view.dart';
import 'package:petsvet_connect/utils/constants.dart';
import '../../../../shared_prefrences/app_prefrences.dart';
import '../../my_profile/views/my_profile_view.dart';
import '../../pet_module/home/views/home_view.dart';
import '../../pet_module/my_appointment/views/my_appointment_view.dart';

class DashboardViewModel extends GetxController {

  PageController pageController = PageController();
  RxInt unreadNotificationCount = 8.obs;
  RxInt unreadMessageCount = 3.obs;
  RxInt selectedIndex = 0.obs;
  RxString role = "".obs;

  List<Widget> screens = [];

  @override
  void onInit() {
    super.onInit();

    role.value = AppPreferences.getRole();
    if(role.value == Constants.roleVet){
      screens = [
        VetHomeView(),
        MyBookingsView(),
        CalenderView(),
        MyProfileView(),
      ];
    }else{
      screens = [
        HomeView(),
        MyAppointmentView(),
        PageView(),
        CalenderView(),
        MyProfileView(),
      ];
    }



  }

  void changePage(index) {
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String? getPetAppBarTitle() {
    if (selectedIndex.value == 1) {
      return "my_appointment".tr;
    }
    if (selectedIndex.value == 2) {
      return "";
    }
    if (selectedIndex.value == 3) {
      return "calender".tr;
    }

    if (selectedIndex.value == 4) {
      return "my_profile".tr;
    }

    return null;
  }

  String? getVetAppBarTitle() {
    if (selectedIndex.value == 1) {
      return "my_booking".tr;
    }
    if (selectedIndex.value == 2) {
      return "calender".tr;
    }

    if (selectedIndex.value == 3) {
      return "my_profile".tr;
    }

    return null;
  }

  bool showLogoAppBar() {
    return selectedIndex.value == 0;
  }


}
