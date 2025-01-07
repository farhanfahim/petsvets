import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import '../../../../../../utils/dimens.dart';

class ReadOnlyWidget extends StatelessWidget {

  final String? leftText;
  final String? rightText;

  ReadOnlyWidget({this.leftText,this.rightText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimen.contentSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        MyText(
          text: leftText!,
          fontWeight: FontWeight.w400,
          color: AppColors.gray600,
          fontSize: 14,
        ),
        const SizedBox(height: AppDimen.pagesVerticalPadding,),
        MyText(
          text: rightText!,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          fontSize: 14,
        ),
      ],),
    );
  }
}