import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
class MedicalRecordTile extends StatelessWidget {

  MedicalRecordTile({this.onTap,this.isLast,super.key});

  final bool? isLast;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                color: AppColors.fieldsBgColor,
                child: const Padding(
                  padding: EdgeInsets.all(AppDimen.contentPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     CommonImageView(
                       imagePath: AppImages.pdf,
                       width: 24,
                     )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(
                      text: "Coco’s Report.xls",
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                    const MyText(
                      text: "82.3kb",
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray600,
                      fontSize: 12,
                    ),

                    SizedBox(height: AppDimen.verticalSpacing.w,),


                  ],
                ),
              ),
              GestureDetector(
                onTap: onTap!,
                child: Row(
                  children: [
                    const CommonImageView(
                      svgPath: AppImages.view,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: MyText(
                        text: "view".tr,
                        fontWeight: FontWeight.w500,
                        color: AppColors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
          Visibility(
            visible: isLast==false?true:false,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding),
              width: double.maxFinite,
              height: 0.4,
              color: AppColors.grey.withOpacity(0.6),
            ),
          )

        ],
      ),
    );
  }
}