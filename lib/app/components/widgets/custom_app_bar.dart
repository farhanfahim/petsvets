import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/app_font_size.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';
import '../resources/app_images.dart';
import 'MyText.dart';
import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.hasBackButton = true,
    this.backImage = AppImages.backIcon,
    this.title = "",
    this.style,
    this.onBackPressed,
    this.elevation = 0,
    this.backgroundColor = AppColors.primaryColor,
    this.backIconColor,
    this.titleColor = AppColors.white,
    this.actions,
    this.titleWidget,
    this.titleSize = 13,
    this.backTitle,
    this.customFlexibleSpace,
    required this.centerTitle,
    required this.titleSpacing,
  });

  final double titleSpacing;
  final bool hasBackButton;
  final bool centerTitle;
  final Widget? titleWidget;
  final Widget? customFlexibleSpace;
  final String backImage;
  final String title;
  final String? backTitle;
  final TextStyle? style;
  final void Function()? onBackPressed;
  final double elevation;
  final double titleSize;
  final Color backgroundColor;
  final Color? backIconColor;
  final Color titleColor;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation:0,
      backgroundColor: AppColors.white,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: hasBackButton,
      titleSpacing: hasBackButton ? titleSpacing : null,
      clipBehavior: Clip.none,
      leadingWidth: hasBackButton?25.w:30.w,
      title: titleWidget ??
          MyText(
            alignRight: true,
            text: title,
            fontFamily: AppFonts.fontMulish,
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.medium,
            color: titleColor,
          ),
      leading: hasBackButton
          ? Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 2.0),
            child: CustomBackButton(
                    backTitle: backTitle??"txt_back".tr,
                backImage: backImage,
                onTap: onBackPressed,
                color: backIconColor ?? AppColors.white,
              ),
          )
          : null,
      actions: actions,
    );
  }
}
