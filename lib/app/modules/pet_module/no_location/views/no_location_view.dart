import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../view_model/no_location_view_model.dart';

class NoLocationView extends StatelessWidget {
  final NoLocationViewModel viewModel = Get.put(NoLocationViewModel());

  NoLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      showAppBar: false,
      hasBackButton: false.obs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImageView(
            imagePath: AppImages.noLocation,
            width: 20.h,
          ),
          SizedBox(height: 3.h),
          MyText(
            text: "no_location".tr,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            fontSize: 16,
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: MyText(
              text: "it_is_mandatory".tr,
              fontWeight: FontWeight.w500,
              center: true,
              color: AppColors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 2.h),
          CustomButton(
            prefix: const CommonImageView(
              svgPath: AppImages.gps,
            ),
            label: 'enable_location'.tr,
            textColor: AppColors.white,
            fontWeight: FontWeight.w600,
            onPressed: () {
              viewModel.onTapEnableLocation();
            },
          ),

        ],
      ),
    );
  }
}
