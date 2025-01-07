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
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/status_widget.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class InboxTile extends StatelessWidget {

  final Function()? onTap;
  String? imageUrl;
  String? username;
  String? lastMessage;
  String? time;
  RxInt? unReadMessages = 0.obs;

  InboxTile({this.unReadMessages,this.imageUrl,this.username,this.lastMessage,this.time,this.onTap,});

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
            top: AppDimen.pagesVerticalPadding),
        padding: const EdgeInsets.all(AppDimen.contentPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            imageUrl!.isNotEmpty?CircleImage(
              imageUrl: imageUrl,
              size: 12.w,
              border: false,
            ):CircleImage(
              image: AppImages.user,
              size: 12.w,
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
                          text: username!,
                          fontWeight: unReadMessages!.value != 0?FontWeight.w700:FontWeight.w500,
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                      MyText(
                        text: time!,
                        fontWeight: unReadMessages!.value != 0?FontWeight.w600:FontWeight.w500,
                        color: unReadMessages!.value != 0?AppColors.black:AppColors.gray600,
                        fontSize: 13,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimen.verticalSpacing,),
                  MyText(
                    text: lastMessage!,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray600,
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