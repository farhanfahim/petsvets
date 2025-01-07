import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import '../../../../../../utils/dimens.dart';

class AppointmentDurationWidget extends StatelessWidget {

  final int? duration;
  const AppointmentDurationWidget({super.key, this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(
          top: AppDimen.pagesVerticalPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    const CommonImageView(
                      width: 18,
                      svgPath: AppImages.videoCall,
                    ),
                    const SizedBox(width: AppDimen.contentSpacing,),
                    Expanded(
                      child: MyText(
                        text: "online_consultation".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: AppDimen.verticalSpacing,),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: MyText(
                    text: "${duration!} mins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}