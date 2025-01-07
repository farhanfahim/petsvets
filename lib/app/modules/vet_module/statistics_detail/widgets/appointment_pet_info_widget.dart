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
import '../../../../components/widgets/common_image_view.dart';

class AppointmentPetInfoWidget extends StatelessWidget {

  final Function()? onTap;

  AppointmentPetInfoWidget({this.onTap,});

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
                        text: "pet_owner_info".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimen.contentPadding,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleImage(
                      image:AppImages.userDummyImg,
                      size: 10.w,
                      border: false,
                    ),
                    const SizedBox(width: AppDimen.contentPadding,),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: "Arlene MacCoy",
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                              CommonImageView(
                                svgPath: AppImages.flag,
                              ),

                            ],
                          ),
                          MyText(
                            text: "arlenemaccoy@hotmail.com",
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                            fontSize: 13,
                          ),


                        ],
                      ),
                    )

                  ],
                ),
                const SizedBox(height: AppDimen.contentPadding,),
                Row(
                  children: [
                    Expanded(
                      child: MyText(
                        text: "consult_for".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimen.contentPadding,),

                Container(

                  decoration: const BoxDecoration(
                    color: AppColors.fieldsBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(AppDimen.borderRadius),
                    ),
                  ),
                  padding: const EdgeInsets.only(left:  AppDimen.contentPadding,right:60,top: AppDimen.contentSpacing,bottom: AppDimen.contentSpacing,),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Tommy",
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      MyText(
                        text: "Dog",
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray600,
                        fontSize: 13,
                      ),
                    ],
                  ),
                )


              ],
            ),
          )

        ],
      ),
    );
  }
}