import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/manage_subscription/widgets/text_widget.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/app_font_size.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../../utils/dimens.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_fonts.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../view_model/manage_subscription_view_model.dart';
import '../widgets/manage_subscription_widget.dart';

class ManageSubscriptionView extends StatelessWidget {
  final ManageSubscriptionViewModel viewModel = Get.put(ManageSubscriptionViewModel());

  ManageSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      titleColor: AppColors.blackColor,
      appBarBackgroundColor: AppColors.white,
      backIconColor: AppColors.blackColor,
      showHeader:false,
      centerTitle: true,
      hasBackButton: true.obs,
      screenName: "manage_subscription".tr,
      child:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimen.pagesVerticalPadding,),
            MyText(
              text: "your_current_subscription".tr,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              fontSize: 14,
            ),
            const SizedBox(height: 4),
            ManageSubscriptionWidget(viewModel.subscriptionModel),
            Obx(() => RichText(
              text: TextSpan(
                  text: !viewModel.hideCancelBtn.value?"next_payment_on".tr:"ends_on".tr,
                  style: AppTextStyles.dontHaveAccountStyle(),
                  children: [
                    TextSpan(
                      text: " ",
                      style: AppTextStyles.dontHaveAccountStyle(),
                    ),
                    TextSpan(
                      text: " 10 Sep 2023",
                      style: AppTextStyles.dontHaveAccountStyle().copyWith(fontWeight: FontWeight.w700),
                    ),
                  ]

              ),
              textAlign: TextAlign.left,
            ),),
             SizedBox(height: AppDimen.verticalSpacing.h),

            Row(
              children: [
                Obx(() => Visibility(
                  visible: !viewModel.hideCancelBtn.value,
                  child: Expanded(
                    child: CustomButton(
                      label: 'cancel'.tr,
                      borderColor: AppColors.red,
                      color: AppColors.white,
                      textColor: AppColors.red,
                      fontWeight: FontWeight.w600,
                      onPressed: () {
                        BottomSheetService.showConfirmationDialog(
                          title: "cancel_subscription",
                          content: "are_you_sure_you_want_to_cancel",
                          leftButtonText: "no",
                          rightButtonText: "yes",
                          onAgree: () async {
                            Get.back();
                            BottomSheetService.showConfirmationDialog(
                                title: "subscription_cancelled",
                                content: "unsubscribed",
                                actions:[
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Get.back();
                                      viewModel.hideCancelBtn.value = true;
                                      return;
                                    },
                                    child: MyText(
                                      text: "okay".tr,
                                      fontFamily: AppFonts.fontMulish,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.red,
                                      fontSize: AppFontSize.regular,
                                    ),
                                  ),
                                ]
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),),
                Obx(() => Visibility(
                  visible: !viewModel.hideCancelBtn.value,
                  child:  const SizedBox(width: AppDimen.allPadding,),
                ),),

                Expanded(
                  child: CustomButton(
                    label: 'upgrade'.tr,
                    borderColor: AppColors.red,
                    color: AppColors.red,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                     Get.toNamed(Routes.SUBSCRIPTION);
                    },
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
