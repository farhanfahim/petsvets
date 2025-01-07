import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../../utils/app_decorations.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';

class MapButtonWidget extends StatelessWidget {

  final String? title;
  final String? image;
  final Function() onTap;

  const MapButtonWidget({this.title = "", this.image = "", required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom:AppDimen.mapButtonPadding),
        padding: const EdgeInsets.all(AppDimen.mapButtonPadding),
        decoration: AppDecorations.boxDecoration(),
        child: Row(

          children: [
            CommonImageView(
              svgPath: image!,
            ),
            Visibility(
              visible: title!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: MyText(
                  text: title!,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}