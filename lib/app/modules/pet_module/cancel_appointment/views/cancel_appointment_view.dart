import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/argument_constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/cancel_appointment_repository.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/cancel_appointment_view_model.dart';

class CancelAppointmentView extends StatelessWidget {

  CancelAppointmentViewModel viewModel = Get.put(CancelAppointmentViewModel(repository: Get.find<CancelAppointmentRepository>()));
  CancelAppointmentView({super.key});


  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      showAppBar: true,
      horizontalPadding: false,
      hasBackButton: true.obs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimen.pagesVerticalPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimen.pagesHorizontalPadding,
                        vertical: AppDimen.pagesVerticalPaddingNew),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "your_cancellation".tr,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          fontSize: 20,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: "cancelation_desc".tr,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 0.4,
                    color: AppColors.grey.withOpacity(0.6),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimen.pagesHorizontalPadding,
                        vertical: AppDimen.pagesVerticalPaddingNew),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: "payment_detail".tr,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                fontSize: 16,
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: "cancelation_fee".tr,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            MyText(
                              text: "\$${viewModel.appointmentData!.amount!}",
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: "your_total_refund".tr,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            MyText(
                              text: "\$${viewModel.appointmentData!.amount!}",
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimen.verticalSpacing.h),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'confirm_cancalation'.tr,
                    controller: viewModel.btnController,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                     viewModel.cancelAppointmentAPI();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
