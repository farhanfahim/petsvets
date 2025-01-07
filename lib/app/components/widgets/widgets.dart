import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

Widget authDivider() {
  return Flexible(
    child: Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Divider(
        thickness: 1,
        color: AppColors.separatorColor,
      ),
    ),
  );
}

BoxDecoration roundedDecoration(Color color, double radius) {
  return BoxDecoration(
      color: color,
      border: Border.all(
        color: color,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

BoxDecoration roundedDecorationTransparency(Color color, double radius, Color bgColor) {
  return BoxDecoration(
      color: bgColor,
      border: Border.all(
        color: color,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}
