import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

class BottomSheetTile extends StatelessWidget {
  const BottomSheetTile({
    super.key,
    this.onTap,
    required this.name,
  });

  final void Function()? onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.bottomSheetDividerColor,
            ),
          ),
        ),
        width: double.maxFinite,
        child: MyText(
          text: name,
          fontFamily: AppFonts.fontMulish,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
          fontSize: AppFontSize.extraSmall,
        ),
      ),
    );
  }
}
