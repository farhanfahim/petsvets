import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(this.title, {super.key} );

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CommonImageView(
                svgPath: AppImages.tick,
              ),
              Padding(
                padding: const EdgeInsets.only(left:10,bottom: 5),
                child: MyText(
                  text: title,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  fontSize: 13,
                ),
              ),

            ],
          ),
        ],
      );

  }
}
