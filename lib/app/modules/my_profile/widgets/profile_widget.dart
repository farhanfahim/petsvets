import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../utils/Util.dart';
import '../../../components/widgets/circle_image.dart';
import '../../../data/models/user_model.dart';

class ProfileWidget extends StatelessWidget {

  final Function()? onTap;
  Rx<UserModel>? userModel;
  ProfileWidget({this.onTap,this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      margin:  const EdgeInsets.only(top: AppDimen.pagesVerticalPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

         Obx(() =>  userModel!.value.user!=null?userModel!.value.user!.userImage!=null?CircleImage(
           imageUrl: userModel!.value.user!.userImage!.mediaUrl,
           size: 18.w,
           border: false,
         ):CircleImage(
           image: AppImages.user,
           size: 18.w,
           border: false,
         ):CircleImage(
           image: AppImages.user,
           size: 18.w,
           border: false,
         ),),

          const SizedBox(width: AppDimen.contentPadding,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => userModel!.value.user!=null?MyText(
                text: userModel!.value.user!.fullName!,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 16,
              ):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),
              const SizedBox(height: AppDimen.verticalSpacing,),
              userModel!.value.user!=null?MyText(
                text: userModel!.value.user!.email!,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
                fontSize: 14,
                ):const SizedBox(width: 100, height: 15.0, child: Skeleton()),
              const SizedBox(height: AppDimen.verticalSpacing,),
              GestureDetector(
                onTap: onTap,
                child: MyText(
                  text: 'view_profile'.tr,
                  fontWeight: FontWeight.w700,
                  color: AppColors.red,
                  fontSize: 14,
                ),
              ),

            ],
          )

        ],
      ),
    );
  }
}