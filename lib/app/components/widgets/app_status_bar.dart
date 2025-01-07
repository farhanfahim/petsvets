import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/app_colors.dart';

class AppStatusBar {
  static getDefaultStatusBar() {
    return SystemUiOverlayStyle(
        statusBarColor:AppColors.white,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark);
  }

  static getCallStatusBar() {
    return const SystemUiOverlayStyle(
        statusBarColor:AppColors.black,
        systemNavigationBarColor: AppColors.grayBottom,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light ,
        statusBarIconBrightness: Brightness.light);
  }

  static splashStatusBar() {
    return SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.white,
        statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark);
  }

  static getTransparentStatusBar() {
    return SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.white,
        statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark);
  }

  static getTransparentLightStatusBar() {
    return SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.white,
        statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: Platform.isIOS ? Brightness.dark : Brightness.light);
  }
}
