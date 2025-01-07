import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/models/setting_model.dart';
import 'package:petsvet_connect/utils/constants.dart';
import '../../../../../config/translations/localization_service.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../utils/Util.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../../utils/dimens.dart';
import '../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../data/models/user_model.dart';
import '../../../repository/setting_repository.dart';
import '../../../routes/app_pages.dart';
import '../widgets/language_type_widget.dart';

class SettingViewModel extends GetxController {

  final SettingRepository repository;

  SettingViewModel({required this.repository});

  Rx<UserModel> userModel = UserModel().obs;
  final controller = ValueNotifier<bool>(false);

  RxBool notificationToggle = false.obs;
  RxList<SettingModel> arrOfSetting = List<SettingModel>.empty().obs;
  RxList<SettingModel> arrOfLanguage = List<SettingModel>.empty().obs;
  RxString language = "".obs;
  @override
  void onInit() {
    super.onInit();
    generateVets();

    arrOfLanguage.add(SettingModel(title: "english",image: AppImages.english,isSelected: false.obs,));
    arrOfLanguage.add(SettingModel(title: "spanish",image: AppImages.spain,isSelected: false.obs,));

    _setSelectedLanguage();

    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      controller.value = userModel.value.user!.pushNotification==1?true:false;
      notificationToggle.value = controller.value;
    });

    if(controller!=null) {
      controller.addListener(() {
        notificationToggleAPI();
      });
    }


  }

  generateVets() async {
    arrOfSetting.add(SettingModel(title: "push_notification",image: AppImages.bellIcon,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "change_language",image: AppImages.global,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "change_password",image: AppImages.lock,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "lbl_terms_conditions",image: AppImages.term,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "lbl_privacy_policy",image: AppImages.privacy,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "delete_account",image: AppImages.trash,isSelected: false.obs,));
    arrOfSetting.add(SettingModel(title: "logout",image: AppImages.logout,isSelected: false.obs,));
  }

  void onTapChangeLanguage() async {

    BottomSheetService.showGenericBottomSheet(
        child:  CustomBottomSheet(showBottomBtn:false,
          showHeader:false,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimen.pagesVerticalPadding),
                MyText(
                  text: "select_language".tr,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  fontSize: 18,
                ),
                const SizedBox(height: AppDimen.pagesVerticalPadding),
                Container(
                  width: double.maxFinite,
                  height: 0.4,
                  color: AppColors.grey.withOpacity(0.6),
                ),
                const SizedBox(height: AppDimen.pagesVerticalPadding),
                MyText(
                  text: "choose_your_language".tr,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 14,
                ),
                const SizedBox(height: AppDimen.pagesVerticalPaddingNew),

                Row(
                  children: [
                    Expanded(
                      child: LanguageTypeWidget(arrOfLanguage[0],(){
                        for(var item in arrOfLanguage){
                          item.isSelected!.value = false;
                        }
                        arrOfLanguage[0].isSelected!.value = true;


                      }),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: LanguageTypeWidget(arrOfLanguage[1],(){
                        for(var item in arrOfLanguage){
                          item.isSelected!.value = false;
                        }
                        arrOfLanguage[1].isSelected!.value = true;

                      }),
                    )
                  ],
                ),
                const SizedBox(height: AppDimen.pagesVerticalPadding),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding),
                    child: CustomButton(
                      label: 'save'.tr,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red,
                      onPressed: () async {
                        Get.back();
                        Rx<SettingModel> selectedModel = SettingModel().obs;

                        for(var item in arrOfLanguage){
                          if(item.isSelected!.value){
                            selectedModel.value = item;
                          }
                        }
                        selectedModel.refresh();
                        if(arrOfLanguage.first.isSelected!.value) {
                          updateLanguage(Constants.english);
                        }else{
                         updateLanguage(Constants.spanish);

                        }

                      },
                    ),
                )
              ],
            ),
          ), )
    );


  }

  void updateLanguage(language) async {
    await AppPreferences.setCurrentLanguage(language: language);
    LocalizationService.updateLanguage(language);
  }

  void _setSelectedLanguage() async {
    var currentLanguage = AppPreferences.getCurrentLanguage();
    //LocalizationService.updateLanguage(currentLanguage);
    if(currentLanguage == Constants.english){
      arrOfLanguage.first.isSelected!.value = true;
    }else{
      arrOfLanguage.last.isSelected!.value = true;
    }
    arrOfLanguage.refresh();
  }


  Future<dynamic> notificationToggleAPI() async {

    Map<String,dynamic> data = {
      "push_notification": notificationToggle.value
    };

    final result = await repository.toggleNotification(data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
      userModel.value.user!.pushNotification = controller.value?1:0;
      AppPreferences.setUserDetails(user: userModel.value);
    });
  }
  Future<dynamic> logoutAPI() async {

    Map<String,dynamic> data = {};

    final result = await repository.logout(data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {

      var currentLanguage = AppPreferences.getCurrentLanguage();

      await AppPreferences.clearPreference();
      await AppPreferences.setCurrentLanguage(language: currentLanguage);

      print("*********************************");
      print(AppPreferences.getCurrentLanguage());
      print(AppPreferences.getCurrentLanguage());

      ///Updating to old language
      await LocalizationService.updateLanguage(currentLanguage);
      Get.offAllNamed(Routes.LOGIN);
    });
  }

}
