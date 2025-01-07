import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../data/models/pet_type_model.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';
import 'common_image_view.dart';

class MultiSelectionWidget extends StatelessWidget {

  MultiSelectionWidget({this.isLast = false,this.hideDivider = false,this.model, this.onTap,super.key});
  bool? isLast = false;
  bool? hideDivider = false;
  final PetTypeModel? model;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: Obx(() => GestureDetector(
        onTap:onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
              child: Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: model!.title!,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                  ),
                  CommonImageView(
                    svgPath: model!.isSelected!.value?AppImages.imgCheckSelect:AppImages.imgUnCheckSelect,
                    width: 5.w,
                  ),

                ],
              ),
            ),
            Visibility(
              visible: !isLast!,
              child: Visibility(
                visible: !hideDivider!,
                child: Container(
                  width: double.maxFinite,
                  height: 0.5,
                  color: AppColors.grey.withOpacity(0.6),
                ),
              ),
            )
          ],
        ),
      ),)
    );
  }
}