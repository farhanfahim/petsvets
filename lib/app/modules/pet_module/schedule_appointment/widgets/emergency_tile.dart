import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/custom_switch.dart';

class EmergencyTile extends StatelessWidget {

  ValueNotifier<bool> controller = ValueNotifier<bool>(true);
  String? title;
  String? subTitle;
  EmergencyTile({required this.controller,this.title,this.subTitle = "",});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
       padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical:  AppDimen.pagesHorizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: MyText(
              text: title!,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.blackColor,
            ),
          ),
          CustomSwitch(
            controller: controller,
            activeColor: AppColors.lightRed,
            height: 22,
            width: 40,
          )


        ],
      ),
    );
  }
}