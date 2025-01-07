import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/utils/app_box_shadows.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';

class AppDecorations {
  static BoxDecoration getRoundedBox({
    Color borderColor = AppColors.primaryColor,
    Color bgColor = AppColors.white,
    double width = 1,
    double borderRadius = AppDimen.borderRadius,
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor,
        width: width,
      ),
    );
  }

  static BoxDecoration getClassBox() {
    return const BoxDecoration(
      color: AppColors.classBg,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimen.borderRadius),
        topRight: Radius.circular(AppDimen.borderRadius),
      ),
    );
  }

  static BoxDecoration getBottomSheetBox() {
    return const BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimen.borderRadius),
        topRight: Radius.circular(AppDimen.borderRadius),
      ),
    );
  }



  static BoxDecoration lectureDecoration({
    Color borderColor = AppColors.grey,
    Color color = AppColors.white,
    double borderWidth = 0.5,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadiusDirectional.circular(AppDimen.borderRadius),
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      boxShadow: [
        AppBoxShadow.getBoxShadow(),
      ],
    );
  }

  static BoxDecoration bottomBarDecoration() {
    return BoxDecoration(
      border: Border(
        top: BorderSide(width: 0.5, color: AppColors.grey.withOpacity(0.5),),
        bottom: const BorderSide(width: 0.0, color: Colors.transparent),
      ),
      color: Colors.white,
    );
  }


  static BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(
        color: AppColors.textFieldBorderColor,
      ),
      boxShadow: [
        AppBoxShadow.getBoxShadow(),
      ],
    );
  }

  static InputDecoration phoneInputDecoration() {
    return InputDecoration(
      fillColor: AppColors.fieldsBgColor,
      filled: true,
      errorMaxLines: 2,
      contentPadding: const EdgeInsets.all(0),
      hintText: "your_phone".tr,
      errorStyle: const TextStyle(color: AppColors.error),
      hintStyle: TextStyle(
        color: AppColors.fieldsHeadingColor,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.fontMulish,
        fontSize: AppFontSize.extraSmall,
      ),
      labelStyle: TextStyle(
        color: AppColors.fieldsHeadingColor,
        fontWeight: FontWeight.w400,
        fontSize: AppFontSize.extraSmall,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(width: 2.0),
      ),

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(width: 1.0, color: AppColors.error)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(width: 1, color: AppColors.textFieldBorderColor)),
    );
  }

  static InputDecoration phoneSearchDecoration() {
    return InputDecoration(
      hintText: "Search",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.textFieldBorderColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.textFieldBorderColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.textFieldBorderColor, width: 1.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.textFieldBorderColor, width: 1.0),
      ),
    );
  }
}
