import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/status_widget.dart';

class AppointmentInfoWidget extends StatelessWidget {

  final StatusType type;
  final Function()? onTap;

  AppointmentInfoWidget({required this.type, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
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
                        text: "appointment_info".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                    StatusWidget(type),
                  ],
                ),

                SizedBox(height: AppDimen.verticalSpacing.w,),
                Row(
                  children: [
                    const CommonImageView(
                      width: 18,
                      svgPath: AppImages.clock,
                      color: AppColors.black,
                    ),
                    const SizedBox(width: AppDimen.contentSpacing,),
                    Expanded(
                      child: MyText(
                        text: "date".tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),
                    const MyText(
                      text: "02/Mar/2023",
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 14,
                    ),

                  ],
                ),
                SizedBox(height: AppDimen.verticalSpacing.w,),
                Row(
                  children: [
                    const CommonImageView(
                      width: 18,
                      svgPath: AppImages.calender,
                      color: AppColors.black,
                    ),
                    const SizedBox(width: AppDimen.contentSpacing,),
                    Expanded(
                      child: MyText(
                        text: "time".tr,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),
                    const MyText(
                      text: "10:00 AM - 10:30 AM",
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 14,
                    ),

                  ],
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}