import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import '../components/resources/app_colors.dart';
import '../components/widgets/app_status_bar.dart';
import '../components/widgets/custom_app_bar.dart';

class BaseViewAuthScreen extends StatelessWidget {
  const BaseViewAuthScreen({
    super.key,
    this.child,
    this.closeApp,
    this.textAlign = TextAlign.center,
    this.screenTitle = "",
    this.leading,
    this.action,
    this.showDivider = false,
    this.showBackButton = true,
    this.showAppBar = true,
    this.leadingIcon = AppImages.backIcon,
    this.onBackTap,
  });

  final Widget? child;
  final bool? closeApp;
  final TextAlign textAlign;
  final String screenTitle;
  final Widget? leading, action;
  final bool showDivider;
  final bool showAppBar, showBackButton;
  final String leadingIcon;
  final void Function()? onBackTap;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBar.getDefaultStatusBar(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: showAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: CustomAppBar(
                  title: screenTitle ?? "",
                  centerTitle: true,
                  titleSpacing: 0,
                  backIconColor: AppColors.blackColor,
                  titleColor: AppColors.blackColor,
                ),
              )
            : null,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(child: child!),
        ),
      ),
    );
  }
}
