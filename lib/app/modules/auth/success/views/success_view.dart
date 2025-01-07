import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/page_type.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../view_model/success_view_model.dart';

class SuccessView extends StatelessWidget {
  final SuccessViewModel viewModel = Get.put(SuccessViewModel());

  SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child:Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageView(
                        imagePath: AppImages.successCheck,
                        width: 25.w,
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      MyText(
                        text: "success".tr,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 20,right: 20),
                        child: MyText(
                          center: true,
                          text: viewModel.data[ArgumentConstants.message],
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: viewModel.data[ArgumentConstants.pageType] == PageType.payment?"okay".tr:viewModel.data[ArgumentConstants.pageType] == PageType.scheduleAppointment?"go_to_home".tr:'continue'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    viewModel.onTap();
                  },
                ),
              ),
            ],
          ),
        )

    );
  }
}

