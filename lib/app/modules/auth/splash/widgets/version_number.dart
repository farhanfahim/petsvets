import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';

class VersionNumber extends StatelessWidget {
  const VersionNumber({Key? key, required this.version}) : super(key: key);

  final String version;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimen.bottomPadding.h),
      child: MyText(
        text: 'App Version: $version',
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: AppFontSize.tiny,
      ),
    );
  }
}
