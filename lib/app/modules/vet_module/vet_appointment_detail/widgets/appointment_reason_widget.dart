import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
class AppointmentReasonWidget extends StatelessWidget {

  const AppointmentReasonWidget({super.key});

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
                MyText(
                  text: "reason_of_appointment".tr,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 16,
                ),

                SizedBox(height: AppDimen.verticalSpacing.w,),
                const MyText(
                  text: "This is dummy. It is not meant to be read. It is placed here solely to demonstrate the look and feel of finished typeset text. Only for show.",
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 13,
                ),


              ],
            ),
          )

        ],
      ),
    );
  }
}