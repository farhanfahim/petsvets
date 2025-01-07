import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

import '../resources/app_colors.dart';

class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final bool? center;
  final bool? alignRight;
  final int? maxLines;
  final FontStyle? fontStyle;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final TextDirection? textDirection;

  const MyText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = AppFontSize.extraSmall,
    this.fontWeight,
    this.overflow,
    this.center,
    this.alignRight,
    this.maxLines,
    this.fontStyle,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.textDecoration,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: center == null
          ? alignRight != null
              ? TextAlign.right
              : TextAlign.left
          : center!
              ? TextAlign.center
              : TextAlign.left,
      maxLines: maxLines,
      textDirection: textDirection,
      style: TextStyle(
        color: color ?? AppColors.textPrimaryColor,
        // fontSize: fontSize.sp,
        fontSize: fontSize,
        letterSpacing: letterSpacing ?? 0.0,
        fontFamily: fontFamily ?? AppFonts.fontMulish,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: textDecoration,
        // height: height,
      ),
    );
  }
}

class TappableText extends MyText {
  final void Function()? onTap;

  const TappableText({
    super.key,
    this.onTap,
    required super.text,
    super.color,
    super.fontSize,
    super.fontWeight,
    super.overflow,
    super.center,
    super.alignRight,
    super.maxLines,
    super.fontStyle,
    super.height,
    super.letterSpacing,
    super.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: super.build(context),
    );
  }
}
