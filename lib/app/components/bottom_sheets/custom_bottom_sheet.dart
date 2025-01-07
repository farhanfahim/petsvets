import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/app_decorations.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../resources/app_images.dart';
import '../widgets/common_image_view.dart';
import '../widgets/custom_button.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    this.showHeader = false,
    this.showClose = false,
    this.showBottomBtn = true,

    this.showAction = false,
    this.actionText = "",
    this.actionColor = AppColors.primaryColor,
    this.actionTap,

    this.showLeading = false,
    this.showLeadingIcon = false,
    this.leadingText = "",
    this.leadingColor = AppColors.primaryColor,
    this.leadingTap,

    this.title = "",
    this.titleSize = AppFontSize.small,
    this.centerTitle = false,

    this.verticalPadding = 0.0,
    this.widget,

    this.onBtnTap,
  });

  final bool showHeader;
  final bool showClose;
  final bool showBottomBtn;

  final bool showAction;
  final String actionText;
  final Color actionColor;
  final void Function()? actionTap;

  final bool showLeading;
  final bool showLeadingIcon;
  final String leadingText;
  final Color leadingColor;
  final void Function()? leadingTap;

  final String? title;
  final double? titleSize;
  final bool? centerTitle;

  final double? verticalPadding;
  final Widget? widget;

  final void Function()? onBtnTap;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: AppDecorations.getBottomSheetBox(),
      child: SafeArea(
        child: Wrap(
          children: [
            Visibility(
              visible: showHeader,
              child: Column(
                children: [
                  AppBar(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100),
                      ),
                    ),
                    backgroundColor: AppColors.white,
                    centerTitle: centerTitle,
                    clipBehavior: Clip.none,
                    title: MyText(
                      text: title!,
                      center: true,
                      fontFamily: AppFonts.fontMulish,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                      fontSize: titleSize!,
                    ),
                    leadingWidth: showLeading?25.w:0,
                    leading: showLeading ? GestureDetector(
                        onTap: leadingTap!,
                        child: Visibility(
                          visible: showLeading,
                          child: Row(
                            children: [
                              Visibility(
                                  visible:showLeadingIcon,
                                  child:  const Padding(
                                    padding: EdgeInsets.only(left:AppDimen.pagesHorizontalPadding,right: 5.0),
                                    child: CommonImageView(
                                      svgPath: AppImages.close,
                                    ),
                                  )),
                              MyText(
                                text: leadingText,
                                fontFamily: AppFonts.fontMulish,
                                fontWeight: FontWeight.w600,
                                color: leadingColor,
                                fontSize: AppFontSize.small,
                              ),
                            ],
                          ),
                        )
                    ): Container(),
                    actions: showAction?[GestureDetector(
                        onTap: actionTap!,
                        child: Padding(
                          padding: const EdgeInsets.only(right:  AppDimen.pagesHorizontalPadding),
                          child: Visibility(
                            visible: showAction,
                            child: showClose? const CommonImageView(
                              svgPath: AppImages.close,
                            ): MyText(
                              text: actionText,
                              fontFamily: AppFonts.fontMulish,
                              fontWeight: FontWeight.w600,
                              color: actionColor,
                              fontSize: AppFontSize.small,
                            ),
                          ),
                        )
                    )]:null,
                  ),
                  Visibility(
                    visible: showHeader,
                    child: Container(
                      width: double.maxFinite,
                      height: 0.5,
                      color: AppColors.grey.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),

            widget!,
            showBottomBtn?Padding(
              padding: const EdgeInsets.symmetric(horizontal:  AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
              child: CustomButton(
                  label: 'done'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  //controller: viewModel.btnController,
                  onPressed: onBtnTap!
              ),
            ):Container()


          ],
        ),
      ),
    );
  }
}
