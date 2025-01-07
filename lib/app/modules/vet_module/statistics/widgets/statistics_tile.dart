import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/components/widgets/status_widget.dart';
import 'package:petsvet_connect/app/data/enums/request_type.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class StatisticsTile extends StatelessWidget {

  final DummyAppointmentModel model;
  final Function()? onTap;

  StatisticsTile({required this.model, this.onTap,});

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
            bottom: AppDimen.pagesVerticalPadding),
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
                            const CommonImageView(
                              svgPath: AppImages.flag,
                            ),
                          ],
                        ),
                      ),

                      StatusWidget(model.type!)
                    ],
                  ),


                  const SizedBox(height: AppDimen.horizontalPadding,),
                  const Row(
                    children: [
                      CommonImageView(
                        width: 16,
                        svgPath: AppImages.calender,
                      ),
                      SizedBox(width: AppDimen.horizontalSpacing,),
                      MyText(
                        text: "2/Mar/2023",
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: 13,
                      ),

                    ],
                  ),
                  const SizedBox(height: AppDimen.verticalSpacing,),
                  MyText(
                    text: "${"amount".tr} \$35",
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    fontSize: 13,
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