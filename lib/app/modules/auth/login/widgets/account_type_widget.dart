import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/data/models/dummy_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';

class AccountTypeWidget extends StatelessWidget {

  const AccountTypeWidget(this.model, this.onTap,{super.key});
  final DummyModel model;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Obx(() => Container(
          decoration: BoxDecoration(
            color: model.isSelected!.value?AppColors.lightBlue:AppColors.fieldsBgColor,
            border: Border.all(color: model.isSelected!.value?AppColors.primaryColor:AppColors.textFieldBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(AppDimen.borderRadius),
            ),
          ),
          padding: const EdgeInsets.all(AppDimen.allPadding),
          child: Row(
            children: [
              CommonImageView(
                imagePath: model.image,
                width: 10.w,
              ),
              SizedBox(width: 2.h,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: model.title!,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: MyText(
                        text: model.subTitle!,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.h),
              CommonImageView(
                svgPath: model.isSelected!.value?AppImages.radioSelected:AppImages.radioUnSelected,
                width: 5.w,
              ),
            ],
          ),
        ),)
      ),
    );
  }
}