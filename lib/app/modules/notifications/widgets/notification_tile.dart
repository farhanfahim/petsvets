import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../utils/date_time_util.dart';
import '../../../components/widgets/circle_image.dart';
import '../../../data/models/notification_model.dart';

class NotificationTile extends StatelessWidget {

  final NotificationData model;
  final Function()? onTap;
  final bool? isLast;
  NotificationTile({required this.model, this.onTap,this.isLast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() => Container(
        color: model.isSelected!.value?AppColors.lightBlue:AppColors.white,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  AppDimen.allPadding,vertical: AppDimen.pagesVerticalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  model.user!.userImage!=null?CircleImage(
                    imageUrl: model.user!.userImage!.mediaUrl!,
                    size: 10.w,
                    border: false,
                  ):CircleImage(
                    image: AppImages.user,
                    size: 10.w,
                    border: false,
                  ),


                  const SizedBox(width: AppDimen.contentPadding,),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: model.title!,
                                fontWeight: model.readAt==null?FontWeight.w700:FontWeight.w500,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: AppDimen.verticalSpacing,),
                        MyText(
                          text: DateTimeUtil.timeAgoSinceDate(model.updatedAt!),
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 13,
                        ),


                      ],
                    ),
                  )

                ],
              ),
            ),
            Visibility(
              visible: !isLast!,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal:  AppDimen.allPadding),
                width: double.maxFinite,
                height: 0.4,
                color: AppColors.grey.withOpacity(0.6),
              ),
            )
          ],
        ),
      ),)
    );
  }
}