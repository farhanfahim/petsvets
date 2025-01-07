import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/shimmers/page_shimmer.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_back_button.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/pet_home_repository.dart';
import '../view_model/vet_profile_view_model.dart';
import '../widgets/vet_location_widget.dart';
import '../widgets/vet_profile_widget.dart';

class VetProfileView extends StatelessWidget {
  VetProfileViewModel viewModel = Get.put(VetProfileViewModel(repository: Get.find<PetHomeRepository>()));

  VetProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        hasBackButton: false.obs,
        showAppBar: false,
        backgroundColor: AppColors.white,
        showHeader: false,
        horizontalPadding: false,
        verticalPadding: false,
        isTop:false,
        child: Obx(() => viewModel.isDataLoading.value?Column(
          children: [


            SizedBox(
                height: 60.w,
                width: double.maxFinite,
                child: Skeleton()),
            SizedBox(
              height: 10.0,
            ),
            PageShimmer(),
          ],
        ):Column(
          children: [
            Stack(
              children: [
                viewModel.model.value.userImage!=null?CommonImageView(
                  url: viewModel.model.value.userImage!.mediaUrl!,
                  height: 60.w,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ):Container(
                  color: AppColors.gray600.withOpacity(0.1),
                  child: CommonImageView(
                    imagePath: AppImages.noThumbnail,
                    height: 60.w,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:kToolbarHeight/1.5,left: AppDimen.horizontalPadding),
                  child: CustomBackButton(
                    backTitle: "txt_back".tr,
                    backImage: AppImages.backIcon,
                    onTap: (){
                      Get.back();
                    },
                    color:  AppColors.black,
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VetProfileWidget(model:viewModel.model.value,address:viewModel.selectedAddress.value),
                    VetLocationWidget(model:viewModel.model.value,address:viewModel.selectedAddress.value),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
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
                label: 'schedule_appointment'.tr,
                borderColor: AppColors.red,
                color: AppColors.red,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Get.toNamed(Routes.SCHEDULE_APPOINTMENT,arguments: {
                    ArgumentConstants.pageType:PageType.profile,
                    ArgumentConstants.id:viewModel.model.value.id
                  });
                },
              ),
            ),

          ],
        )));
  }
}
