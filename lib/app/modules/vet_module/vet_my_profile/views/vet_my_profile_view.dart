import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_my_profile/widgets/readonly_widget.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../repository/vet_profile_repository.dart';
import '../view_model/vet_my_profile_view_model.dart';

class VetMyProfileView extends StatelessWidget {

  VetMyProfileViewModel viewModel = Get.put(VetMyProfileViewModel(repository: Get.find<VetProfileRepository>()));

  VetMyProfileView({super.key});


  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.white,
        showAppBar: true,
        verticalPadding: false,
        horizontalPadding: false,
        hasBackButton: true.obs,
        child: SingleChildScrollView(
          child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              padding: const EdgeInsets.all(AppDimen.allPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => viewModel.userModel.value.user!=null?
                  viewModel.userModel.value.user!.userImage!=null?Center(
                    child: CircleImage(
                      imageUrl: viewModel.userModel.value.user!.userImage!.mediaUrl,
                      size: 24.w,
                      border: false,
                    ),
                  ):Center(
                    child: CircleImage(
                      image: AppImages.user,
                      size: 24.w,
                      border: false,
                    ),
                  ):Center(
                    child: CircleImage(
                      image: AppImages.user,
                      size: 24.w,
                      border: false,
                    ),
                  ),),
                  Obx(() =>  viewModel.userModel.value.user!=null?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: viewModel.userModel.value.user!.fullName!,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                      Visibility(
                        visible: viewModel.userModel.value.user!.accessPharmacy==1?true:false,
                        child: CommonImageView(
                          svgPath: AppImages.flag,
                          width: 5.w,
                        ),
                      )
                    ],
                  ):const SizedBox(width: 100, height: 15.0, child: Skeleton())),

                  const SizedBox(height: AppDimen.verticalSpacing,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.VET_EDIT_PROFILE);
                    },
                    child: Center(
                      child: MyText(
                        text: 'edit_profile'.tr,
                        fontWeight: FontWeight.w700,
                        color: AppColors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "email_address".tr,rightText: viewModel.userModel.value.user!.email??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.address.value.isNotEmpty?ReadOnlyWidget(leftText: "location".tr,rightText: viewModel.address.value??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "phone_number".tr,rightText: viewModel.userModel.value.user!.phone??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "alt_phone_number".tr,rightText: viewModel.userModel.value.user!.alternatePhone??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "specialization".tr,rightText: viewModel.userModel.value.user!.userDetail!.vetType ==10?"Doctor of Veterinary Medicine":"Licensed Veterinary Technician",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "state_license_number".tr,rightText: viewModel.userModel.value.user!.userDetail!.stateLicenseNumber??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "state_license".tr,rightText: viewModel.userModel.value.user!.userDetail!.stateLicense??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "national_license".tr,rightText: viewModel.userModel.value.user!.userDetail!.nationalLicenseNumber??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "dea_number".tr,rightText: viewModel.userModel.value.user!.userDetail!.deaNumber??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  ReadOnlyWidget(leftText: "pet_specialization".tr,rightText: "Large Animal",),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "working_hours".tr,rightText: viewModel.userModel.value.user!.userDetail!=null?"${DateTimeUtil.formatDate(viewModel.userModel.value.user!.userDetail!.startTime!,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)} - ${DateTimeUtil.formatDate(viewModel.userModel.value.user!.userDetail!.endTime!,inputDateTimeFormat:DateTimeUtil.dateTimeFormat11,outputDateTimeFormat: DateTimeUtil.dateTimeFormat9)}":"-",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),

                  const Divider(color: AppColors.gray600,thickness: 0.2,),
                  Obx(() => viewModel.userModel.value.user!=null?ReadOnlyWidget(leftText: "about_vet".tr,rightText: viewModel.userModel.value.user!.userDetail!.about??"",):const SizedBox(width: 100, height: 15.0, child: Skeleton()),),
                ],
              )
          )
        ));
  }
}
