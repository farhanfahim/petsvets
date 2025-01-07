import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';


// ignore: must_be_immutable
class AttachmentDialog extends StatelessWidget {
  AttachmentDialog({required this.onTapDoc,required this.onTapCamera,required this.onTapGallery});
  Function() onTapDoc;
  Function() onTapCamera;
  Function() onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.textFieldBorderColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimen.borderRadius),
        ),
      ),
       margin: const EdgeInsets.only(bottom: AppDimen.contentPadding),
       padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPaddingNew),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTapDoc,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  CommonImageView(
                    imagePath: AppImages.doc,
                    width: 12.w,
                  ),
                  const SizedBox(height: AppDimen.bottomPadding,),
                  MyText(text: "document".tr,fontSize: 12,)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapCamera,
            child: Column(
              children: [
                CommonImageView(
                  imagePath: AppImages.camera,
                  width: 12.w,
                ),
                const SizedBox(height: AppDimen.bottomPadding,),
                MyText(text: "camera".tr,fontSize: 12,)
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapGallery,
            child: Padding(
              padding: const EdgeInsets.only(right:15),
              child: Column(
                children: [
                  CommonImageView(
                    imagePath: AppImages.gallery,
                    width: 12.w,
                  ),
                  const SizedBox(height: AppDimen.bottomPadding,),
                  MyText(text: "gallery".tr,fontSize: 12,)
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
}
