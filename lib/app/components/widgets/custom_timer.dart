// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';

import 'custom_text.dart';

class CustomTimer extends CustomTextWidget {

  CustomTimer({Key? key,
    required int seconds,
    super.color = Colors.black,
    super.fontSize = 14,
    // super.a = TextAlign.start,
    super.fontWeight = FontWeight.normal,
    // super.underlined = false,
    // super.italic = false,
    // super.,
    // super.isSp = true,
    // super.max_lines, //double line_spacing=1.2,
    super.fontFamily = AppFonts.fontMulish,
    // super.lineThrough = false,
}) : super(key: key,text: getElapsedTime(seconds));


  static String getElapsedTime(int seconds) {
    int hours = 0, mins = 0, secs = 0;
    double hh = seconds / 3600;
    if (hh >= 1) {
      hours = hh.toInt();
      seconds = seconds - (3600 * hours);
      double mm = seconds / 60;
      if (mm >= 1) {
        mins = mm.toInt();
        secs = seconds - (60 * mins);
      } else {
        secs = seconds;
      }
    } else {
      double mm = seconds / 60;
      if (mm >= 1) {
        mins = mm.toInt();
        secs = seconds - (60 * mins);
      } else {
        secs = seconds;
      }
    }
    // return "${hours<=9?"0":""}${hours}:${mins<=9?"0":""}${mins}:${secs<=9?"0":""}${secs}";
    return "${mins <= 9 ? "0" : ""}$mins:${secs <= 9 ? "0" : ""}$secs";
  }

}


