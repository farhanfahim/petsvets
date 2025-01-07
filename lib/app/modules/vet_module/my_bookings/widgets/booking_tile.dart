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
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/status_widget.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class BookingTile extends StatelessWidget {

  final DummyAppointmentModel model;
  final Function()? onTap;

  BookingTile({required this.model, this.onTap,});

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
            CircleImage(
              image: model.image!,
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
                        child: Row(
                          children: [
                            MyText(
                              text: model.name!,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                            const SizedBox(width: 5,),
                            Visibility(
                              visible: model.type == StatusType.confirmed || model.type ==StatusType.pending,
                              child: const CommonImageView(
                                svgPath: AppImages.flag,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Visibility(
                          visible: model.type != StatusType.completed,
                          child: StatusWidget(model.type!)),
                    ],
                  ),
                  const SizedBox(height: AppDimen.verticalSpacing,),
                  const MyText(
                    text: "30 min",
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
                      const MyText(
                        text: "2/Mar/2023",
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
                        text: model.timings!,
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