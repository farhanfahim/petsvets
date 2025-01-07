import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'MyText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.color,
    required this.onPressed,
    this.enabled,
    this.textColor,
    this.fontSize = AppFontSize.extraSmall,
    this.fontWeight,
    this.prefix,
    this.borderColor,
    this.borderRadius = AppDimen.borderRadius,
    this.width,
    this.height = 50,
    this.controller,
  });

  final String label;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? enabled;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final double? width;
  final double height;
  final double borderRadius;
  final RoundedLoadingButtonController? controller;

  @override
  Widget build(BuildContext context) {

    return controller == null
        ? SizedBox(
            height: height,
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.buttonDisableColor,
                disabledForegroundColor: AppColors.buttonDisableColor,
                foregroundColor: color ?? AppColors.red,
                backgroundColor: color ?? AppColors.red,
                elevation: 0,
                side: BorderSide(
                  width: 0.8,
                  color: enabled ?? true ? borderColor ?? Colors.transparent : borderColor?.withOpacity(0.5) ?? Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              onPressed: enabled ?? true ? onPressed : null,
              child: prefix != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        prefix ?? const SizedBox(width: 0.0, height: 0.0),
                        const SizedBox(width: 8),
                        MyText(
                          text: label,
                          maxLines: 1,
                          fontFamily: AppFonts.fontMulish,
                          color: (enabled ?? true ? (textColor ?? AppColors.textPrimaryColor) : (textColor?.withOpacity(0.5) ?? AppColors.white)),
                          fontSize: fontSize,
                          fontWeight: fontWeight ?? FontWeight.w500,
                        )
                      ],
                    )
                  :  MyText(
                text: label,
                maxLines: 1,
                fontFamily: AppFonts.fontMulish,
                color: (enabled ?? true ? (textColor ?? AppColors.textPrimaryColor) : (textColor?.withOpacity(0.5) ?? AppColors.white)),
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
              ),
            ),
          )
        : RoundedLoadingButton(
            width: width ?? double.maxFinite,
            height: height,
            onPressed: onPressed,
            animateOnTap: false,
            elevation: 0,
            borderRadius: borderRadius,
            disabledColor: AppColors.backgroundColor,
            controller: controller!,
            color: color ?? AppColors.red,
            child:  MyText(
              text: label,
              maxLines: 1,
              fontFamily: AppFonts.fontMulish,
              color: (enabled ?? true ? (textColor ?? AppColors.textPrimaryColor) : (textColor?.withOpacity(0.5) ?? AppColors.white)),
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
            )
          );
  }
}
