import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';

import '../resources/app_fonts.dart';
import 'MyText.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.backImage,
    this.color = AppColors.white,
    this.backTitle,
    this.onTap,
  });

  final String backImage;
  final String? backTitle;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: AppColors.transparent,
      icon: Row(
        children: [
          SvgPicture.asset(
            backImage,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: MyText(
              text: backTitle?? "txt_back".tr,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w400,
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
      onPressed: () {
        if (onTap == null) {
          Get.back();
          return;
        }
        onTap!();
      },
    );
  }
}
