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
import '../../../../data/models/pet_response_model.dart';
import '../../../../data/models/pet_type_model.dart';

class PetTileWidget extends StatelessWidget {

  final Function()? onTap;
  Data? model = Data();
  final bool? isLast;
  PetTileWidget({this.onTap,this.model,this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal:AppDimen.allPadding),
      child: Column(
        children: [
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    MyText(
                      text: model!.name!,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: 14,
                    ),
                    const SizedBox(height: AppDimen.verticalSpacing,),
                    MyText(
                      text: model!.breed!,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray600,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: CommonImageView(
                  svgPath: AppImages.trash,
                  width: 5.w,
                  color: AppColors.gray600,
                ),
              )
            ],
          ),
            const SizedBox(height: 5,),
            isLast!?const SizedBox(height: AppDimen.pagesVerticalPadding,):const Divider(color: AppColors.gray600,thickness: 0.2,)
        ],
      )
    );
  }
}