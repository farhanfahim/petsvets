import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../utils/argument_constants.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../data/enums/page_type.dart';
import '../../../routes/app_pages.dart';
import '../view_model/subscription_view_model.dart';
import '../widgets/subscription_widget.dart';

class SubscriptionView extends StatelessWidget {
  final SubscriptionViewModel viewModel = Get.put(SubscriptionViewModel());

  SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
      titleColor: AppColors.blackColor,
      appBarBackgroundColor: AppColors.white,
      backIconColor: AppColors.blackColor,
      showHeader:false,
      hasBackButton: true.obs,
      screenName: "",
      child:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CommonImageView(
                svgPath: AppImages.subscription,
                width: 25.w,
              ),
            ),
            SizedBox(height: AppDimen.verticalSpacing.h),
            Center(
              child: MyText(
                text: "subscription".tr,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 26,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: MyText(
                  text: "upgrade_to_premium".tr,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: AppDimen.verticalSpacing.h),
            MyText(
              text: "choose_your_plan".tr,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              fontSize: 16,
            ),
            SizedBox(height: 1.h),
            SizedBox(
              height: 80.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.arrOfSubscription.length,
                  itemBuilder: (BuildContext context, int index) =>
                      SubscriptionWidget(viewModel.arrOfSubscription[index],(){
                        Get.toNamed(Routes.PAYMENT_DETAIL,arguments: {
                          ArgumentConstants.pageType:PageType.subscription,
                        });
                      })
              ),
            ),

          ],
        ),
      ),
    );
  }
}
