import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/data/enums/page_type.dart';
import 'package:petsvet_connect/app/modules/my_profile/widgets/setting_tile.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/widgets/custom_switch.dart';
import '../../../routes/app_pages.dart';
import '../view_model/my_profile_view_model.dart';
import '../widgets/profile_widget.dart';


class MyProfileView extends StatelessWidget {
  final MyProfileViewModel viewModel = Get.put(MyProfileViewModel());

  MyProfileView({super.key});



  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child: Column(
          children: [
            ProfileWidget(
              userModel: viewModel.userModel,
              onTap: (){

              if(viewModel.role.value == Constants.roleVet){
                Get.toNamed(Routes.VET_MY_PROFILE);
              }else{
                Get.toNamed(Routes.PROFILE);
              }
            },),
            SizedBox(height: 1.h,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.arrOfSetting.length,
                itemBuilder: (BuildContext context, int index) {
                  return SettingTile(
                    widget: index == 0 && viewModel.role.value == Constants.roleVet?CustomSwitch(
                      controller: viewModel.controller,
                      activeColor: AppColors.primaryColor,
                      width: 45,
                    ):null,
                    color:AppColors.black,
                    isPng: index == 3 && viewModel.role.value == Constants.rolePet?true:false,
                    model:viewModel.arrOfSetting[index],
                    onTap: () {
                      if(viewModel.role.value == Constants.rolePet){
                        if(index == 0){
                          Get.toNamed(Routes.APPOINTMENT_HISTORY);

                        }else if(index == 1){
                          Get.toNamed(Routes.ADDRESSES);

                        }else if(index == 2){
                          Get.toNamed(Routes.MEDICAL_RECORD,arguments: {
                            ArgumentConstants.pageType:PageType.setting
                          });

                        }else if(index == 3){
                          Get.toNamed(Routes.MANAGE_SUBSCRIPTION);

                        }else if(index == 4){
                          Get.toNamed(Routes.PAYMENT_MANAGEMENT);

                        }else if(index == 5){
                          Get.toNamed(Routes.SETTING);

                        }else if(index == 6){
                          Get.toNamed(Routes.CONTACT_US);
                        }
                      }else{
                        if(index == 1){
                          Get.toNamed(Routes.MANAGE_TIME_SLOT);

                        }else if(index == 2){
                          Get.toNamed(Routes.VET_APPOINTMENT_HISTORY);

                        }else if(index == 3){
                          Get.toNamed(Routes.PAYMENT_MANAGEMENT);

                        }else if(index == 4){
                          Get.toNamed(Routes.STATISTICS);

                        }else if(index == 5){
                          Get.toNamed(Routes.SETTING);
                        }
                        else if(index == 6){
                          Get.toNamed(Routes.CONTACT_US);
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
