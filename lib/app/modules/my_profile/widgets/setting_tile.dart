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
import '../../../data/models/setting_model.dart';

class SettingTile extends StatelessWidget {

  final Function()? onTap;
  final SettingModel? model;
  final bool? isPng;
  final bool? showPadding;
  final Color? color;
  final Widget? widget;
  String? subTitle;
  SettingTile({this.showPadding = true,this.color=AppColors.black,this.isPng = false,this.onTap,this.model,this.subTitle = "",this.widget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppDimen.borderRadius),
        )),
        margin:  showPadding!?const EdgeInsets.only(top: AppDimen.pagesVerticalPadding,left: AppDimen.pagesHorizontalPadding,right: AppDimen.pagesHorizontalPadding):EdgeInsets.zero,
        padding: showPadding!?const EdgeInsets.only(top: 12,bottom: 12,left: 10,right: 10):const EdgeInsets.symmetric(horizontal:5,vertical: AppDimen.pagesVerticalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            isPng!?CommonImageView(
              imagePath: model!.image!,
              width: 24,
            ):CommonImageView(
              svgPath: model!.image!,
              width: 24,
            ),
            SizedBox(width: 3.w,),
            Expanded(
              child: MyText(
                text: model!.title!.tr,
                fontWeight: FontWeight.w400,
                color: color,
                fontSize: 14,
              ),
            ),

            widget??const CommonImageView(
              svgPath: AppImages.arrowLeft,
            ),


          ],
        ),
      ),
    );
  }
}