import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
class AlertWidget extends StatelessWidget {

  final String? image;
  final String? title;
  final Color? color;
  const AlertWidget({this.image,this.title = "",this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom:AppDimen.contentPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 40,width: 4,color: color!,),
          const SizedBox(width: 10,),
          CommonImageView(
            imagePath: image!,
            width: 5.w,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: MyText(
              text: title!,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              fontSize: 14,
            ),
          )

        ],
      ),
    );
  }
}