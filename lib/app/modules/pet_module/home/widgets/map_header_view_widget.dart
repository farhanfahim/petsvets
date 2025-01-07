import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../../utils/app_decorations.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';

class MapHeaderViewWidget extends StatelessWidget {

  final String? title;
  final String? secondaryTitle;
  final String? image;
  final Function() onTap;

  const MapHeaderViewWidget({this.title = "", this.secondaryTitle ="",this.image = "", required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: const EdgeInsets.only(top:AppDimen.mapButtonPadding),
      padding: const EdgeInsets.all(AppDimen.mapButtonPadding),
      decoration: AppDecorations.boxDecoration(),
      child: Row(

        children: [
          CommonImageView(
            svgPath: image!,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MyText(
                text: title!,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: MyText(
              text: secondaryTitle!,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}