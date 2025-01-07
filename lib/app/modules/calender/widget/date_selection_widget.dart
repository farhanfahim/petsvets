import 'package:flutter/material.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/dimens.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/resources/app_fonts.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/common_image_view.dart';

class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({
    Key? key,
    required this.date,
    this.onTap,
  }) : super(key: key);

  final String date;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.chatSenderColor1,
        padding: const EdgeInsets.only(left: AppDimen.pagesHorizontalPadding,right: AppDimen.pagesHorizontalPadding,top: AppDimen.contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CommonImageView(
              svgPath: AppImages.calendar3,
            ),
            const SizedBox(width: AppDimen.horizontalSpacing),
            MyText(
              text: date,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
              fontSize: AppFontSize.small,
            ),
            const SizedBox(width: AppDimen.horizontalSpacing),
            const CommonImageView(
              svgPath: AppImages.downArrow2,
            ),
          ],
        ),
      ),
    );
  }
}
