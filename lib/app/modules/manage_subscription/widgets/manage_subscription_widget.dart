import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/data/models/subscription_model.dart';
import 'package:petsvet_connect/app/modules/manage_subscription/widgets/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../utils/app_box_shadows.dart';
import '../../../../utils/app_text_styles.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';

class ManageSubscriptionWidget extends StatelessWidget {
  const ManageSubscriptionWidget(this.model, {super.key} );

  final SubscriptionModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    vertical: AppDimen.pagesVerticalPadding,horizontal: AppDimen.pagesHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: MyText(
                            text: "per_month_".tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDimen.verticalSpacing,
                    ),


                    const TextWidget("Limited Number of Pets"),
                    const TextWidget("Appointment Booking"),
                    const TextWidget("List of Nearby Vets"),
                    const TextWidget("Consultation Fee Payment"),
                    const TextWidget("Appointment Management"),
                    const TextWidget("Appointment History"),
                    const TextWidget("Pet Health Records"),
                    const TextWidget("Profile Management"),

                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),

            ],
          ),
        ));
  }
}
