import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/app/data/models/appointment_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';

class AppointmentPaymentWidget extends StatelessWidget {
  final AppointmentData model;
  final Function()? onTap;

  AppointmentPaymentWidget({
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: AppDimen.pagesVerticalPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "payment_detail".tr,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 16,
                ),
                SizedBox(
                  height: AppDimen.verticalSpacing.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: "consultation_fee".tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),
                       MyText(
                      text: "\$${model.amount!}",
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                  ],
                ),
                Visibility(
                    visible: model.type == StatusType.cancelled,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyText(
                              text: "your_total_refund".tr,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          MyText(
                            text: "\$${model.amount!}",
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
