import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/my_profile/widgets/setting_tile.dart';
import 'package:petsvet_connect/app/repository/setting_repository.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import '../../../../utils/argument_constants.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/widgets/custom_switch.dart';
import '../../../data/enums/page_type.dart';
import '../view_model/setting_view_model.dart';


class SettingView extends StatelessWidget {
  SettingViewModel viewModel = Get.put(SettingViewModel(repository: Get.find<SettingRepository>()));

  SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        centerTitle: true,
        screenName: "setting".tr,
        horizontalPadding: false,
        verticalPadding: false,
        child: Column(
          children: [

            Expanded(
              child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.arrOfSetting.length,
                itemBuilder: (BuildContext context, int index) {
                  return SettingTile(
                    color:index == 6?AppColors.red:AppColors.black,
                    subTitle: index == 1?viewModel.language.value:"",
                    widget: index == 0?CustomSwitch(
                      controller: viewModel.controller,
                      activeColor: AppColors.primaryColor,
                      width: 45,
                    ):null,
                    model:viewModel.arrOfSetting[index],
                    onTap: () {
                      if(index == 1){
                        viewModel.onTapChangeLanguage();
                      }else if(index == 2){
                        Get.toNamed(Routes.CHANGE_PASSWORD);
                      }else if(index == 3){
                        Get.toNamed(Routes.PAGE, arguments: { ArgumentConstants.pageType: PageType.terms,});
                      }else if(index == 4){
                        Get.toNamed(Routes.PAGE, arguments: { ArgumentConstants.pageType: PageType.privacy,});
                      }else if(index == 5){
                        Get.toNamed(Routes.DELETE_ACCOUNT);
                      }else if(index == 6){
                        BottomSheetService.showConfirmationDialog(
                          title: "logout",
                          content: "are_you_sure_want_to_logout",
                          leftButtonText: "cancel",
                          rightButtonText: "lbl_logout",
                          onAgree: () async {
                            Get.back();
                            viewModel.logoutAPI();
                          },
                        );
                      }
                    },
                  );
                },
              )),
            ),
          ],
        ));
  }
}
