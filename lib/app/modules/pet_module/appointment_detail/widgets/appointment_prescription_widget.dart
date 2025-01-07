import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';

class AppointmentPrescriptionInfoWidget extends StatelessWidget {

  final Function()? onTap;
  String? title = "";

  AppointmentPrescriptionInfoWidget({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top:AppDimen.contentPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: "prescription_mode".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: MyText(
                        text: "select_mode".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimen.verticalSpacing.w,),
                MyText(
                  text: title!,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 14,
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}