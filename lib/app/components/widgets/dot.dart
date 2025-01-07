import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/dimens.dart';

class Dot extends StatelessWidget {
  const Dot({super.key, this.color = AppColors.white});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimen.borderRadius),
      ),
    );
  }
}
