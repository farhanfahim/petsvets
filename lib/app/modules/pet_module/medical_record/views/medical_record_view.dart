import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/baseviews/base_view_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/app_text_styles.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/multi_image_view.dart';
import '../../../../data/enums/page_type.dart';
import '../view_model/medical_record_view_model.dart';

class MedicalRecordView extends StatelessWidget {
  final MedicalRecordViewModel viewModel = Get.put(MedicalRecordViewModel());

  MedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      resizeToAvoidBottomInset:true,
      hasBackButton: true.obs,
      centerTitle: true,
      verticalPadding: viewModel.data[ArgumentConstants.pageType] == PageType.setting?false:true,
      horizontalPadding: false,

      backgroundColor: AppColors.white,
      screenName: viewModel.data[ArgumentConstants.pageType] == PageType.setting?"pet_health_record".tr:"medical_records".tr,
      backTitle: viewModel.data[ArgumentConstants.pageType] == PageType.setting?"txt_back".tr:"txt_cancel".tr,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SizedBox(height: viewModel.data[ArgumentConstants.pageType] == PageType.setting?0:AppDimen.verticalSpacing.h,),
                    Visibility(
                      visible: viewModel.data[ArgumentConstants.pageType] == PageType.scheduleAppointment,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),

                        child: RichText(
                          text: TextSpan(
                            text: "add_medical_records".tr,
                            style: AppTextStyles.fieldLabelStyle(),
                            children: [
                              TextSpan(
                                text: " *",
                                style: AppTextStyles.asteriskStyle(),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
                    Obx(() => viewModel.userModel.value!=null?MultiImageView(
                        sidePadding:true,
                        showColor:true,
                        showDivider:viewModel.data[ArgumentConstants.pageType] == PageType.setting?false:true,
                        bottomPadding:viewModel.data[ArgumentConstants.pageType] == PageType.setting?5:20.0,
                        arrOfImage:  viewModel.arrOfImage,
                        coverTitle: "upload_record".tr):Container(),)

                  ],
                ),
              ),
            ),
          ), 
          Visibility(
            visible: viewModel.data[ArgumentConstants.pageType] == PageType.scheduleAppointment,
            child: Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

              child: CustomButton(
                label: 'save'.tr,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Get.back(result: viewModel.arrOfImage);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
