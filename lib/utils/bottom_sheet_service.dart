import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

class BottomSheetService {
  static final BottomSheetService _singleton = BottomSheetService._internal();

  factory BottomSheetService() {
    return _singleton;
  }

  BottomSheetService._internal();

  static void showGenericBottomSheet<T>({
    required Widget child,
  }) {
    Get.bottomSheet(
      isScrollControlled: true,
      GestureDetector(
        onTap: () {
          Util.hideKeyBoard(Get.context!);
        },
        child: child,
      ),
      backgroundColor: Colors.transparent,
    ).then((value) {
      print("Closing showGenericBottomSheet");
      Get.delete<T>();
    });
  }

  static void showGenericModalBottomSheet<T>({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        onTap: () {
          Util.hideKeyBoard(context);
        },
        child: child,
      ),
    ).then((value) {
      print("Closing showGenericModalBottomSheet");
      Get.delete<T>();
    });
  }

  static Future<dynamic> showGenericDialog<T>({
    required Widget child,
  }) {
    return Get.dialog(
      child,
      barrierDismissible: false,
    );
  }

  static Future<dynamic> showConfirmationDialog<T>({
    required String title,
    required String content,
    String leftButtonText = "no",
    String rightButtonText = "yes",
    Function()? onDisagree,
    Function()? onAgree,
    List<Widget>? actions,
  }) {
    return Get.dialog(

      CupertinoAlertDialog(
        insetAnimationDuration: const Duration(milliseconds: 10),
        title: Column(
          children: [

            MyText(
              text: title.tr,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              center: true,
              fontSize: AppFontSize.medium,
            ),
          ],
        ),
        content: MyText(
          text: content.tr,
          fontFamily: AppFonts.fontMulish,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
          center: true,
          fontSize: AppFontSize.extraSmall,
        ),
        actions: actions ??
            [
              CupertinoDialogAction(
                onPressed: () {
                  if (onDisagree == null) {
                    Get.back();
                    return;
                  }
                  onDisagree();
                },
                child: MyText(
                  text: leftButtonText.tr,
                  fontFamily: AppFonts.fontMulish,
                  fontWeight: FontWeight.w600,
                  color: AppColors.red,
                  fontSize: AppFontSize.regular,
                ),
              ),
              CupertinoDialogAction(
                onPressed: onAgree,
                child: MyText(
                  text: rightButtonText.tr,
                  fontFamily: AppFonts.fontMulish,
                  fontWeight: FontWeight.w600,
                  color: AppColors.red,
                  fontSize: AppFontSize.regular,
                ),
              ),
            ],
      ),
      barrierDismissible: false,
    );
  }
}
