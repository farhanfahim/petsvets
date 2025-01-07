import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../data/models/setting_model.dart';

class LanguageTypeWidget extends StatelessWidget {

  const LanguageTypeWidget(this.model, this.onTap,{super.key});
  final SettingModel model;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onTap,
      child: Obx(() => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: model.isSelected!.value?AppColors.lightBlue:AppColors.fieldsBgColor,
              border: Border.all(color: model.isSelected!.value?AppColors.primaryColor:AppColors.textFieldBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(AppDimen.borderRadius),
              ),
            ),
            margin: const EdgeInsets.only(right:  5,top: 5),
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonImageView(
                  imagePath: model.image,
                  width: 24,
                ),
                const SizedBox(width: 10),
                MyText(
                  text: model.title!.tr,
                  fontWeight: model.isSelected!.value?FontWeight.w700:FontWeight.w600,
                  color: AppColors.primaryColor,
                  fontSize: 20,
                ),

              ],
            ),
          ),
          Visibility(
            visible: model.isSelected!.value,
            child: Positioned(
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(color:  AppColors.primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(100),
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: const CommonImageView(
                  svgPath: AppImages.tick,
                  color: AppColors.white,
                  width: 10,
                ),
              ),
            ),
          )
        ],
      ),),
    );
  }
}