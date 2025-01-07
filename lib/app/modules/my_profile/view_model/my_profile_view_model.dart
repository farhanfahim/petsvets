import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/models/setting_model.dart';

import '../../../../shared_prefrences/app_prefrences.dart';
import '../../../../utils/constants.dart';
import '../../../data/models/user_model.dart';

class MyProfileViewModel extends GetxController {

  RxList<SettingModel> arrOfSetting = List<SettingModel>.empty().obs;
  final controller = ValueNotifier<bool>(true);
  RxString role = "".obs;

  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();

    role.value = AppPreferences.getRole();
    if(role.value == Constants.rolePet){
      generatePet();
    }else{
      generateVets();
    }


    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      print("farhan95");
      print(userModel.value.user!.toJson());
    });
  }

  generatePet() async {
    arrOfSetting.add(SettingModel(title: "appointment_history",image: AppImages.history,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "addresses",image: AppImages.settingLocation,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "pet_health_records",image: AppImages.clipboard,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "manage_subscription",image: AppImages.manageSubscriptionPng,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "payment_management",image: AppImages.card,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "settings",image: AppImages.setting,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "contact_us",image: AppImages.contactUs,isSelected: false.obs,));
  }

  generateVets() async {
    arrOfSetting.add(SettingModel(title: "emergency_location",image: AppImages.emergencyLocation,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "manage_time_slot",image: AppImages.timeSlot,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "appointment_history",image: AppImages.menuBoard,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "payment_management",image: AppImages.card,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "statistic",image: AppImages.chart,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "settings",image: AppImages.setting,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "contact_us",image: AppImages.contactUs,isSelected: false.obs,));
  }



}
