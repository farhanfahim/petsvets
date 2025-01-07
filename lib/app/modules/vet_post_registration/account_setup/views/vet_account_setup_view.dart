import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/vet_post_registration/general_info/views/general_info_view.dart';
import 'package:petsvet_connect/app/modules/vet_post_registration/payment/views/payment_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../view_model/vet_account_setup_view_model.dart';

class VetAccountSetupView extends StatelessWidget {
  final VetAccountSetupViewModel viewModel = Get.put(VetAccountSetupViewModel());

  VetAccountSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseViewScreen(
      hasBackButton: viewModel.currentPage.value!=0?true.obs:false.obs,
      horizontalPadding: false,
      verticalPadding: false,
      titleColor: AppColors.blackColor,
      appBarBackgroundColor: AppColors.white,
      backIconColor: AppColors.blackColor,
      screenName: "account_setup".tr,
      centerTitle: true,
      onBackPressed: (){
        if(viewModel.currentPage.value==1){
          viewModel.previousPage();
        }
      },
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: AppDimen.formSpacing,),
                Obx(
                      () => EasyStepper(
                    activeStep: viewModel.currentPage.value,
                    internalPadding: 5,
                    showLoadingAnimation: false,
                    enableStepTapping: false,
                    stepRadius: 10,
                    defaultStepBorderType: BorderType.normal,
                    lineStyle: LineStyle(
                      lineLength: 65.w,
                      lineThickness: 1,
                      lineType: LineType.normal,
                      defaultLineColor:  AppColors.primaryColor,
                    ),
                    showStepBorder: false,
                    steps: [

                      EasyStep(
                        customStep: viewModel.step1.value==0?const CommonImageView(
                          svgPath: AppImages.stepDefault,
                        )
                            : CommonImageView(
                          svgPath: viewModel.step1.value==1
                              ? AppImages.stepUnselected
                              : AppImages.stepSelected,
                        ),
                        customTitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MyText(
                            center: true,
                            text: "general_info".tr,
                            color: viewModel.step1.value==1
                                ? AppColors.primaryColor
                                : AppColors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      EasyStep(
                        customStep: viewModel.step2.value==0?const CommonImageView(
                          svgPath: AppImages.stepDefault,
                        )
                            : CommonImageView(
                          svgPath: viewModel.step2.value==1
                              ? AppImages.stepUnselected
                              : AppImages.stepSelected,
                        ),
                        customTitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MyText(
                            center: true,
                            text: "payment".tr,
                            color: viewModel.step2.value==1
                                ? AppColors.primaryColor
                                : AppColors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),

              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: viewModel.pageController,
              onPageChanged: (v){
                if (v == 0) {
                  viewModel.step1.value = 1;
                  viewModel.step2.value = 0;
                }
                if (v == 1) {
                  viewModel.step1.value = 2;
                  viewModel.step2.value = 1;
                }
                viewModel.currentPage.value = v;
              },
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GeneralInfoView(),
                PaymentView()
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
