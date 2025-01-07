import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../data/models/appointment_model.dart';

class AppointmentDoctorInfoWidget extends StatelessWidget {

  final Function()? onTap;
  final Vet? model;
  AppointmentDoctorInfoWidget({this.model,this.onTap,});

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
                        text: "doctor_info".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: MyText(
                        text: "view_profile".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppDimen.verticalSpacing.w,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model!.userImage!=null?CircleImage(
                      imageUrl: model!.userImage!.mediaUrl!,
                      size: 10.w,
                      border: false,
                    ):CircleImage(
                      image: AppImages.user,
                      size: 10.w,
                      border: false,
                    ),
                    const SizedBox(width: AppDimen.contentPadding,),

                     Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: model!.fullName!,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                          const SizedBox(height: AppDimen.verticalSpacing,),
                          const MyText(
                            text: "Emergency and Critical Care",
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                            fontSize: 13,
                          ),


                        ],
                      ),
                    )

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