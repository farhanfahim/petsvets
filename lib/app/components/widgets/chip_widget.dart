import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../utils/dimens.dart';
import '../../data/models/pet_type_model.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';
import 'common_image_view.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget(
      {this.color = AppColors.chipColor,
      this.model,
      this.verticalPadding = AppDimen.pagesVerticalPadding,
      this.isClose = true,
      this.onTap,
      super.key});

  final PetTypeModel? model;
  final Color? color;
  final bool? isClose;
  final double? verticalPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 5, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            color: color!,
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: AppDimen.pagesHorizontalPadding,
              vertical: verticalPadding!),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text: model!.title!,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 12,
              ),
              Visibility(
                visible: isClose!,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const CommonImageView(
                        svgPath: AppImages.close,
                        width: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
