import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/app_text_styles.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    super.key,
    required this.label,
    this.mandatory = true,
    this.isBold = false,
  });

  final String label;
  final bool mandatory;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label.tr,
        style: AppTextStyles.fieldLabelStyle().copyWith(fontWeight: isBold?FontWeight.w600:FontWeight.w400),
        children: mandatory
            ? [
                TextSpan(
                  text: " *",
                  style: AppTextStyles.asteriskStyle(),
                ),
              ]
            : null,
      ),
      textAlign: TextAlign.left,
    );
  }
}
