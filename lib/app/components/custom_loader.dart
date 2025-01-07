import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 2,
      ),
    );
  }
}
