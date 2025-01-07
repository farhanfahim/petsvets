import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/chip_widget.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/vet_detail_model.dart';

class VetProfileWidget extends StatelessWidget {

  final VetDetailResponseModel? model;
  final String? address;
  const VetProfileWidget({this.model,this.address, super.key} );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MyText(
            text: model!.fullName!,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            fontSize: 20,
          ),
          SizedBox(height: AppDimen.verticalSpacing.w,),
          ChipWidget(
              model:model!.userDetail!.vetType == 10?
              PetTypeModel(title: "Doctor of Veterinary Medicine",breed:"".obs,isSelected:false.obs):
              PetTypeModel(title: "Licensed Veterinary Technician",breed:"".obs,isSelected:false.obs),
              color: AppColors.grey.withOpacity(0.2),
              isClose:false,
              verticalPadding: 6.0,
              onTap:(){

          }),
          SizedBox(height: AppDimen.verticalSpacing.w,),
          MyText(
            text: "about".tr,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            fontSize: 16,
          ),
           ReadMoreText(
            model!.userDetail!.about!,
            trimLines: 2,
            style:const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.visible,
            ),
            colorClickableText: AppColors.primaryColor,
            trimCollapsedText: 'read_more'.tr,
            trimExpandedText: 'read_less'.tr,
            moreStyle:const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.visible,
            ),
          ),
          SizedBox(height: AppDimen.verticalSpacing.w,),
           Row(
            children: [
              const CommonImageView(
                width: 15,
                svgPath: AppImages.msg,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: AppDimen.contentSpacing,),
              Expanded(
                child: MyText(
                  text: model!.email!,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize: 13,
                ),
              ),

            ],
          ),
          SizedBox(height: AppDimen.verticalSpacing.w,),
           Row(
            children: [
              const CommonImageView(
                width: 15,
                svgPath: AppImages.location,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: AppDimen.contentSpacing,),
              Expanded(
                child: MyText(
                  text: address!,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  fontSize: 13,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}