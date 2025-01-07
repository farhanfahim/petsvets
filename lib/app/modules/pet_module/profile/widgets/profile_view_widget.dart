import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/shimmers/text_shimmer.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/profile/widgets/readonly_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../utils/Util.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../data/models/user_model.dart';

class ProfileViewWidget extends StatelessWidget {

  final Function()? onTap;

  Rx<UserModel>? userModel;
  ProfileViewWidget({this.onTap,this.userModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => userModel!.value.user!=null?
          userModel!.value.user!.userImage!=null?CircleImage(
            imageUrl: userModel!.value.user!.userImage!.mediaUrl,
            size: 24.w,
            border: false,
          ):CircleImage(
            image: AppImages.user,
            size: 24.w,
            border: false,
          ):CircleImage(
            image: AppImages.user,
            size: 24.w,
            border: false,
          ),),
        Obx(() =>  userModel!.value.user!=null?Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
             MyText(
               text: userModel!.value.user!.fullName!,
               fontWeight: FontWeight.w700,
               color: AppColors.black,
               fontSize: 16,
             ),
           Visibility(
                visible: userModel!.value.user!.accessPharmacy==1?true:false,
                child: CommonImageView(
                  svgPath: AppImages.flag,
                  width: 5.w,
                ),
              )
            ],
          ):const SizedBox(width: 100, height: 15.0, child: Skeleton())),
          const SizedBox(height: AppDimen.verticalSpacing,),
          GestureDetector(
            onTap: onTap,
            child: MyText(
              text: 'edit_profile'.tr,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
          Obx(() => userModel!.value.user!=null?ReadOnlyWidget(leftText: "email_address".tr,rightText: userModel!.value.user!.email!):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),
          const Divider(color: AppColors.gray600,thickness: 0.2,),
          Obx(() => userModel!.value.user!=null?ReadOnlyWidget(leftText: "phone_number".tr,rightText: userModel!.value.user!.phone!):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),
          const Divider(color: AppColors.gray600,thickness: 0.2,),
          Obx(() => userModel!.value.user!=null?ReadOnlyWidget(leftText: "alt_phone_number".tr,rightText: userModel!.value.user!.alternatePhone ?? "-"):const SizedBox(width: 100, height: 15.0, child: Skeleton())),

        ],
      )
    );
  }
}