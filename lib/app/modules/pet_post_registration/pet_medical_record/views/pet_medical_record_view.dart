import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/baseviews/base_view_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/multi_image_view.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../view_model/pet_medical_record_view_model.dart';

class PetMedicalRecordView extends StatelessWidget {
  PetMedicalRecordViewModel viewModel = Get.put(PetMedicalRecordViewModel(repository: Get.find<PetPostRegistrationRepository>()));

  PetMedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      horizontalPadding:false,
      verticalPadding: false,
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset:true,
      showAppBar: false,
      hasBackButton: false.obs,
      child: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  MyText(
                    text: "do_you_have_any".tr,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 20,
                  ),
                  SizedBox(height: 1.h),
                  MultiImageView(showDivider:false,bottomPadding:20.0,arrOfImage:  viewModel.arrOfImage,coverTitle: "upload_record".tr),


                ],
              ),
            ),
          ),),
          SizedBox(height: AppDimen.verticalSpacing.h),

          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

            child: CustomButton(
              label: 'continue'.tr,
              controller: viewModel.btnController,
              textColor: AppColors.white,
              fontWeight: FontWeight.w600,
              onPressed: () {
                viewModel.onTapNext();
              },
            ),
          ),

        ],
      ),
    );
  }
}
