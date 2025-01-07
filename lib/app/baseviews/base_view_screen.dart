import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/utils/dimens.dart';

import '../components/widgets/app_status_bar.dart';
import '../components/widgets/custom_app_bar.dart';

class BaseViewScreen extends StatelessWidget {
    BaseViewScreen({
    super.key,
    required this.child,
    this.showBottomBar = true,
    this.horizontalPadding = true,
    this.verticalPadding = false,
    this.backTitle,
    this.screenName,
    required this.hasBackButton,
    this.backgroundColor = AppColors.backgroundColor,
    this.showAppBar = true,
    this.showHeader = true,
    this.centerTitle = false,
    this.resizeToAvoidBottomInset,
    this.customBottomBar,
    this.actions,
    this.titleWidget,
    this.onBackPressed,
    this.backImage = AppImages.backIcon,
    this.backIconColor = AppColors.primaryColor,
    this.titleColor = AppColors.primaryColor,
    this.appBarBackgroundColor = AppColors.white,
    this.titleSpacing = 0,
    this.height = kToolbarHeight+1,
    this.customFlexibleSpace,
    this.extendedAppBar = false,
    this.isTop = true,
    this.canPop = true,
    this.onPopInvoked,
  });

  final bool showBottomBar;
  final bool horizontalPadding;
  final bool verticalPadding;
  RxBool hasBackButton = true.obs;

  final bool showHeader;
  final bool centerTitle;
  final String backImage;
  final double titleSpacing;

  final double height;
  final String? backTitle;
  final String? screenName;
  final Color? backgroundColor;
  final Color appBarBackgroundColor;
  final Color backIconColor;
  final Color titleColor;
  final bool showAppBar;
  final bool extendedAppBar;
  final Widget? customFlexibleSpace;
  final bool? resizeToAvoidBottomInset;
  final Widget child;
  final Widget? customBottomBar;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final Function()? onBackPressed;
  final void Function(bool)? onPopInvoked;
  final bool canPop;
  final bool isTop;

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: canPop,
      onPopInvoked: onPopInvoked,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppStatusBar.getDefaultStatusBar(),
        child: Scaffold(
          extendBody: true,
          backgroundColor: backgroundColor,
          bottomNavigationBar: customBottomBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
          appBar: showAppBar
              ? PreferredSize(
                  preferredSize: showHeader?Size.fromHeight(height):const Size.fromHeight(kToolbarHeight),
                  child: Column(
                    children: [
                      CustomAppBar(
                        titleSpacing: titleSpacing,
                        backTitle: backTitle ?? "txt_back".tr,
                        title: screenName ?? "",
                        hasBackButton: hasBackButton.value,
                        centerTitle: centerTitle,
                        actions: actions,
                        backImage: backImage,
                        backgroundColor: appBarBackgroundColor,
                        titleColor: titleColor,
                        backIconColor: backIconColor,
                        titleWidget: titleWidget,
                        onBackPressed: onBackPressed,
                        customFlexibleSpace: customFlexibleSpace,
                      ),
                      Visibility(
                        visible: showHeader?true:false,
                        child: Container(
                          width: double.maxFinite,
                          height: 0.4,
                          color: AppColors.grey.withOpacity(0.6),
                        ),
                      )

                    ],
                  ),
                )
              : null,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              top: isTop,
              child: Container(
                color: AppColors.backgroundColor,
                padding: EdgeInsets.only(
                  left: horizontalPadding ? AppDimen.pagesHorizontalPadding : 0,
                  right: horizontalPadding ? AppDimen.pagesHorizontalPadding : 0,
                  top: verticalPadding ? AppDimen.pagesVerticalPadding : 0,
                ),
                child: child,
              ),
            ),
          ),

        ),
      ),
    );
  }
}
