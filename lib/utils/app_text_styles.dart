import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

class AppTextStyles {
  static TextStyle fieldLabelStyle() {
    return const TextStyle(
      fontSize: AppFontSize.verySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontFamily: AppFonts.fontMulish,
    );
  }

  static TextStyle checkBoxLabelStyle() {
    return const TextStyle(
      fontSize: AppFontSize.verySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
      fontStyle: FontStyle.normal,
      fontFamily: AppFonts.fontMulish,
    );
  }

  static TextStyle asteriskStyle() {
    return const TextStyle(
      // fontSize: AppFontSize.tiny.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.tiny,
      fontWeight: FontWeight.w800,
      color: AppColors.red,
    );
  }

  static TextStyle dontHaveAccountStyle() {
    return const TextStyle(
      // fontSize: AppFontSize.tiny.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    );
  }

  static TextStyle vetTileStyle() {
    return const TextStyle(
      // fontSize: AppFontSize.tiny.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.verySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
    );
  }


  static TextStyle accountVerification() {
    return const TextStyle(
      fontSize: AppFontSize.extraSmall,
      fontFamily: AppFonts.fontMulish,
      fontWeight: FontWeight.w400,
      color: AppColors.grey,
      height: 1.7,
    );
  }

  static TextStyle maskEmail() {
    return const TextStyle(
      // fontSize: AppFontSize.extraSmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
    );
  }

  static TextStyle pinCode() {
    return const TextStyle(
      fontFamily: AppFonts.fontMulish,
      fontWeight: FontWeight.w600,
      // fontSize: AppFontSize.regular.sp,
      fontSize: AppFontSize.regular,
      color: AppColors.blackColor,
    );
  }

  static TextStyle uaePassDescription() {
    return TextStyle(
      // fontSize: AppFontSize.verySmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.verySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.fieldsHeadingColor,
      height: 1.3,
    );
  }

  static TextStyle uaePassClickHere() {
    return TextStyle(
      // fontSize: AppFontSize.verySmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.verySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.fieldsHeadingColor,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle calendarDayText() {
    return const TextStyle(
      // fontSize: AppFontSize.extraSmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
      color: AppColors.blackColor,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle calendarHeaderText() {
    return const TextStyle(
      color: AppColors.blackColor,
      fontWeight: FontWeight.w600,
      // fontSize: AppFontSize.regular.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.regular,
    );
  }

  static TextStyle calendarWeekDay() {
    return   TextStyle(
      color: AppColors.grey.withOpacity(0.4),
      fontWeight: FontWeight.w400,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
    );
  }

  static TextStyle calendarSelectedDay() {
    return const TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.w600,
      // fontSize: AppFontSize.extraSmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
    );
  }

  static TextStyle calendarOutside() {
    return const TextStyle(
      color: AppColors.grey,
      fontWeight: FontWeight.w500,
      // fontSize: AppFontSize.extraSmall.sp,
      fontFamily: AppFonts.fontMulish,
      fontSize: AppFontSize.extraSmall,
    );
  }

  static TextStyle calendarStripNormal() {
    return const TextStyle(
      // fontSize: AppFontSize.extraSmall.sp,
      fontSize: AppFontSize.extraSmall,
      color: Colors.black,
      fontFamily: AppFonts.fontMulish,
      fontWeight: FontWeight.w400,
    );
  }
}
