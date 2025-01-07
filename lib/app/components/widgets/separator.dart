import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/utils/dimens.dart';

class Separator extends StatelessWidget {
  const Separator({
    super.key,
    this.height = AppDimen.verticalSpacing,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      color: AppColors.backgroundColor,
    );
  }
}
