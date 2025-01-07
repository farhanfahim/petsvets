import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/status_widget.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class AppointmentTile extends StatelessWidget {

  final AppointmentData model;
  final Function()? onTap;

  AppointmentTile({required this.model, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.textFieldBorderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimen.borderRadius),
          ),
        ),
        margin: const EdgeInsets.only(
            left: AppDimen.pagesHorizontalPadding,
            right: AppDimen.pagesHorizontalPadding,
            top: AppDimen.pagesVerticalPadding),
        padding: const EdgeInsets.all(AppDimen.contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            model.user!=null?CircleImage(
              imageUrl: model.user!.userImage!.mediaUrl,
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
                          text: model.user!.fullName!,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Visibility(
                          visible:model.type != StatusType.completed,child: StatusWidget(model.type!)),
                    ],
                  ),
                  const SizedBox(height: AppDimen.verticalSpacing,),
                  MyText(
                    text: "${model.duration} mins",
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                  const SizedBox(height: AppDimen.horizontalPadding,),
                  Row(
                    children: [
                      const CommonImageView(
                        width: 16,
                        svgPath: AppImages.calender,
                      ),
                      const SizedBox(width: AppDimen.horizontalSpacing,),
                      MyText(
                        text: DateTimeUtil.formatDate(model.appointmentDate!),
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                      const SizedBox(width: AppDimen.contentPadding,),
                      const CommonImageView(
                        width: 16,
                        svgPath: AppImages.clock,
                      ),
                      const SizedBox(width: AppDimen.horizontalSpacing,),
                      MyText(
                        text: model!=null?"${DateTimeUtil.formatDate(model.startTime,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)} - ${DateTimeUtil.formatDate(model.endTime,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)}":"-",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: 13,
                      ),
                    ],
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}