import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../data/models/breed_model.dart';

class BreedSingleSelectionWidget extends StatelessWidget {

  String? image;
  bool? showDivider;
  bool? showPadding;
  double titleFont;
  double breedFont;
  final BreedData? model;
  final Function()? onTap;

  BreedSingleSelectionWidget({this.titleFont = 16,this.breedFont=14,this.image = "",this.showDivider = true,this.showPadding = true,this.model, this.onTap,super.key});

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:onTap,
        child: Column(
          children: [
            Container(
              padding: showPadding!? const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding):EdgeInsets.zero,
              child: Row(
                children: [
                  Visibility(
                    visible: image!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: CommonImageView(
                        imagePath: image,
                        width: 12.w,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: model!.name!.isNotEmpty,
                          child: MyText(
                            text: model!.name!,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                            fontSize: breedFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() =>  CommonImageView(
                    svgPath: model!.isSelected!.value?AppImages.radioSelected:AppImages.radioUnSelected,
                    width: 5.w,
                  ),)

                ],
              ),
            ),
            Visibility(
              visible: showDivider!,
              child: Container(
                width: double.maxFinite,
                height: 0.5,
                color: AppColors.grey.withOpacity(0.6),
              ),
            )
          ],
        ),
      )
    );
  }
}