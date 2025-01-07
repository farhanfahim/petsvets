import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/utils/dimens.dart';

import '../resources/app_colors.dart';
import 'custom_button.dart';

class CustomDialogue extends StatelessWidget {
  final String dialogueBoxHeading;
  final String dialogueBoxText;
  final String? yesText;
  final String? noText;
  final String? image;
  final VoidCallback actionOnYes;
  final VoidCallback actionOnNo;
  final bool isSingleButton;
  final double? height;

  CustomDialogue(
      {Key? key,
      required this.dialogueBoxHeading,
      required this.dialogueBoxText,
      required this.actionOnNo,
      this.yesText,
      this.noText,
      this.image,
      this.height,
      this.isSingleButton = false,
      required this.actionOnYes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppDimen.pagesVerticalPadding,
            ),
            CommonImageView(
              svgPath: image,
            ),
            const SizedBox(
              height: AppDimen.pagesVerticalPadding,
            ),
            MyText(
              text: dialogueBoxHeading,
              fontSize: 22,
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              child: MyText(
                text: dialogueBoxText,
                fontSize: 14,
                center: true,
                color: AppColors.gray600,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: double.maxFinite,
              color: AppColors.backgroundColor,
            ),
            if (isSingleButton)
                  CustomButton(
                  height: 40,
                  label: yesText!,
                  borderColor: AppColors.red,
                  color: AppColors.red,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w700,
                  onPressed: actionOnYes)
            else
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      label: noText!,
                      borderColor: AppColors.red,
                      color: AppColors.backgroundColor,
                      textColor: AppColors.red,
                      fontWeight: FontWeight.w700,
                      onPressed: actionOnNo
                    ),
                  ),
                  const SizedBox(width: AppDimen.allPadding,),
                  Expanded(
                    child: CustomButton(
                        height: 40,
                      label: yesText!,
                      borderColor: AppColors.red,
                      color: AppColors.red,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w700,
                      onPressed: actionOnYes
                    ),
                  ),

                ],
              ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
