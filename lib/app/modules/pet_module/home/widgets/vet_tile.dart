import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/models/dummy_vets_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../data/models/vet_response_model.dart';

class VetTile extends StatelessWidget {

  bool hideSidePadding;
  final dynamic model;
  final Function()? onTap;

  VetTile({this.hideSidePadding = false, required this.model, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.textFieldBorderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimen.borderRadius),
          ),
        ),
        margin: hideSidePadding ? EdgeInsets.zero : const EdgeInsets.only(
            left: AppDimen.pagesHorizontalPadding,
            right: AppDimen.pagesHorizontalPadding,
            top: AppDimen.pagesVerticalPadding),
        padding: const EdgeInsets.all(AppDimen.contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            model.userImage!=null?CircleImage(
              imageUrl: model.userImage!.mediaUrl!,
              size: 10.w,
              border: false,
            ):CircleImage(
              image: AppImages.user,
              size: 10.w,
              border: false,
            ),
            const SizedBox(width: AppDimen.contentPadding,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: model.fullName!,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 14,
                ),
                const SizedBox(height: AppDimen.verticalSpacing,),
                MyText(
                  text:model.fullName!,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                  fontSize: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimen.horizontalPadding,),
                    Obx(() => model.address!.value.isEmpty?const Skeleton(width: 150,height: 20,):Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: CommonImageView(
                            width: 14,
                            svgPath: AppImages.location,
                          ),
                        ),
                        const SizedBox(width: AppDimen.horizontalSpacing,),
                        Obx(() =>  Container(
                          width: 70.w,
                          child: MyText(
                            text: model.address!.value,
                            maxLines: 2,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                            fontSize: 13,
                          ),
                        ),),
                      ],
                    ),),
                    const SizedBox(height: AppDimen.horizontalPadding,),
                    Row(
                      children: [
                        const CommonImageView(
                          width: 16,
                          svgPath: AppImages.clock,
                        ),
                        const SizedBox(width: AppDimen.horizontalSpacing,),
                        MyText(
                          text: model.userDetail!=null?"${DateTimeUtil.formatDate(model.userDetail!.startTime!,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)} - ${DateTimeUtil.formatDate(model.userDetail!.endTime!,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)}":"-",
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}