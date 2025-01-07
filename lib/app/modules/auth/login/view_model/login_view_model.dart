import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/config/translations/localization_service.dart';
import 'package:petsvet_connect/shared_prefrences/app_prefrences.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../data/models/dummy_model.dart';
import '../../../../firestore/firestore_controller.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginViewModel extends GetxController {
  var formKey = GlobalKey<FormState>();

  final AuthRepository repository;

  LoginViewModel({required this.repository});

  
  TextEditingController emailController = TextEditingController(text: "");
  FocusNode emailNode = FocusNode();
  TextEditingController passwordController = TextEditingController(text: "");
  FocusNode passwordNode = FocusNode();
  RxList<DummyModel> arrOfAccountType = List<DummyModel>.empty().obs;
  Rx<bool> absorb = false.obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  Rx<bool> showPassword = true.obs;
  Rx<bool> isCheck = false.obs;
  Rx<AccountType>? selectedType = AccountType.pet.obs;

  @override
  void onInit() {
    super.onInit();
    arrOfAccountType.add(DummyModel(id: "1",image: AppImages.imgPetType,title: "txt_pet_owner".tr,type:AccountType.pet,subTitle: "txt_pet_owner_desc".tr,isSelected:false.obs));
    arrOfAccountType.add(DummyModel(id: "2",image: AppImages.imgVetType,title: "txt_veterinarians".tr,type:AccountType.vet,subTitle: "txt_veterinarians_desc".tr,isSelected:false.obs));

  }

  Rx<bool> checkRoleSelection(){
    RxBool isChecked = false.obs;
    for(var item in arrOfAccountType){
      if(item.isSelected!.value){
        isChecked.value =true;
      }
    }
    return isChecked;
  }

  void onLoginTap() {
    ///Set current language according to server
     _setSelectedLanguage();

    if (formKey.currentState?.validate() == true) {
      loginAPI();
    } else {
      print('not validated');
    }
  }


  Future<dynamic>  loginAPI() async {

    if (formKey.currentState!.validate()) {
      absorb.value = true;
      btnController.start();
      await Future.delayed(Duration(seconds: 1));
      var data = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'device_token': "abc",
        'platform': (Platform.isIOS) ? 'ios' : 'android',
        'device_type': 'mobile',
      };

      final result = await repository.userLogin(data);
      result.fold((l) {
        print(l.message);

        Util.showAlert(title: l.message,error: true);
        absorb.value = false;
        btnController.error();
        btnController.reset();

      }, (response) {
        absorb.value = false;
        btnController.success();
        btnController.reset();

        if(response.data.user!.isVerified != 1) {

          Get.toNamed(Routes.VERIFY_OTP, arguments: {
            ArgumentConstants.pageType: PageType.signIn,
            ArgumentConstants.email: emailController.text.trim(),
          });
        } else {

          AppPreferences.setUserDetails(user: response.data);

          AppPreferences.setAccessToken(token: response.data.accessToken!.token!);

          FirestoreController.instance.saveUserData(
              response.data.user!.id!,
              response.data.user!.fullName,
              response.data.user!.email,
              response.data.user!.userImage!=null?response.data.user!.userImage!.mediaUrl!:"",
              response.data.user!.roles!.first.id);

          if (response.data.user!.isCompleted! == 1) {

            if(response.data.user!.roles!.first.id == 2){
              AppPreferences.setRole(role: Constants.rolePet);
            }
            else if(response.data.user!.roles!.first.id == 3){
              AppPreferences.setRole(role: Constants.roleVet);
            }
            AppPreferences.setIsLoggedIn(loggedIn: true);
            Get.offAllNamed(Routes.DASHBOARD_VIEW);

          } else {
            if(response.data.user!.roles!.first.id == 2){
              AppPreferences.setRole(role: Constants.rolePet);
              Get.offAllNamed(Routes.ACCOUNT_SETUP);
            }
            else if(response.data.user!.roles!.first.id == 3){
              AppPreferences.setRole(role: Constants.roleVet);
              Get.offAllNamed(Routes.VET_ACCOUNT_SETUP);
            }
          }
        }
      });
    }
  }

  void _setSelectedLanguage() async {
    var currentLanguage = AppPreferences.getCurrentLanguage();
    LocalizationService.updateLanguage(currentLanguage);
  }

}
