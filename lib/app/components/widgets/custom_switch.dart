import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> controller;
  final Color activeColor, inactiveColor;
  final double? width, height;
  final double radius;
  final Color thumbColor;

  const CustomSwitch({
    super.key,
    this.activeColor = AppColors.primaryColor,
    this.thumbColor = AppColors.white,
    this.inactiveColor = AppColors.gray600,
    required this.controller,
    this.width,
    this.height,
    this.radius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: controller,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      initialValue: controller.value,
      thumb: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: thumbColor,
        ),
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      width: width ?? 10.w,
      height: height ?? 3.h,
    );
  }
}
