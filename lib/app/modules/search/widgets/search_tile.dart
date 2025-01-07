import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/circle_image.dart';
import '../../../data/models/dummy_appointment_model.dart';
import '../../../data/models/vet_response_model.dart';

class SearchTile extends StatelessWidget {

  bool? isLast;
  final VetData model;
  final Function()? onTap;

  SearchTile({required this.model, this.onTap,this.isLast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(

        padding: const EdgeInsets.symmetric(vertical:AppDimen.contentPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      text: model.fullName!,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: 14,
                    ),


                  ],
                )

              ],
            ),
            const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
            Visibility(
              visible: isLast == false?true:false,
              child: Container(
                width: double.maxFinite,
                height: 0.4,
                color: AppColors.grey.withOpacity(0.6),
              ),
            )
          ],
        ),
      ),
    );
  }
}