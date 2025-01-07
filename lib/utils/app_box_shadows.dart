import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';

class AppBoxShadow {
  static BoxShadow getBoxShadow({Offset? offset}) {
    return BoxShadow(
      color: AppColors.grey.withOpacity(0.5),
      blurRadius: 1,
      spreadRadius: 0,
      offset: offset ?? const Offset(0, 0),
    );
  }
}
