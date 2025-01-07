import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/data/models/subscription_model.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../utils/app_box_shadows.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../data/enums/page_type.dart';
import '../../../routes/app_pages.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget(this.model, this.onTap, {super.key});

  final SubscriptionModel model;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Obx(
          () => GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40.w,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            AppBoxShadow.getBoxShadow(),
                          ],
                          border: Border.all(
                              color: model.isSelected!.value
                                  ? AppColors.primaryColor
                                  : AppColors.textFieldBorderColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimen.borderRadius),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: AppDimen.pagesVerticalPadding),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimen.pagesVerticalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            MyText(
                              text: model.title!,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                              fontSize: 18,
                            ),
                            const SizedBox(
                              height: AppDimen.verticalSpacing,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: MyText(
                                    text: "\$ ",
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                                MyText(
                                  text: model.price!.toString(),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                  fontSize: 35,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppDimen.verticalSpacing,
                            ),
                            MyText(
                              text: "per_month".tr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            MyText(
                              text: "${"total".tr} \$540 ${"per_year".tr}",
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimen.pagesHorizontalPadding),
                              child: CustomButton(
                                label: 'continue'.tr,
                                height: 35,
                                textColor: AppColors.red,
                                borderColor: AppColors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: AppFontSize.verySmall,
                                color: AppColors.white,
                                onPressed: onTap
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: model.isSelected!.value,
                          child: Positioned(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical:  AppDimen.verticalPadding),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(AppDimen.borderRadius),
                              ),
                            ),
                            child: MyText(
                              text: "most_popular".tr,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          )))
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  MyText(
                    text: model.desc!,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
