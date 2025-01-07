import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/bottom_sheet_tile.dart';
import 'package:petsvet_connect/utils/app_decorations.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ImagePickerView extends StatelessWidget {
  const ImagePickerView({
    super.key,
    this.takePictureTap,
    this.uploadPictureTap,
    this.fileTap,
  });

  final void Function()? takePictureTap;
  final void Function()? uploadPictureTap;
  final void Function()? fileTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.getBottomSheetBox(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.allPadding),
          child: Wrap(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: "select_action".tr,
                      fontFamily: AppFonts.fontMulish,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      fontSize: AppFontSize.small,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: AppDimen.verticalPadding.h),
                      child: MyText(
                        text: "cancel".tr,
                        fontFamily: AppFonts.fontMulish,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: AppFontSize.small,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.bottomSheetDividerColor,
                thickness: 1,
              ),
              BottomSheetTile(
                name: "take_picture".tr,
                onTap: () {
                  if (takePictureTap != null) {
                    takePictureTap!();
                  }
                  Get.back();
                },
              ),
              BottomSheetTile(
                name: "upload_picture".tr,
                onTap: () {
                  if (uploadPictureTap != null) {
                    uploadPictureTap!();
                  }
                  Get.back();
                },
              ),
              Visibility(
                visible: fileTap != null,
                child: BottomSheetTile(
                  name: "upload_doc".tr,
                  onTap: () {
                    fileTap!();
                    Get.back();
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
