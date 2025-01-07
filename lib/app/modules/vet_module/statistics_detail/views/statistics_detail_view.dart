import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/custom_button.dart';
import '../view_model/statistics_detail_model.dart';
import '../widgets/appointment_duration_widget.dart';
import '../widgets/appointment_info_widget.dart';
import '../widgets/appointment_payment_widget.dart';
import '../widgets/appointment_pet_info_widget.dart';

class StatisticsDetailView extends StatelessWidget {
  final StatisticsDetailViewModel viewModel =
      Get.put(StatisticsDetailViewModel());

  StatisticsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        titleColor: AppColors.blackColor,
        backIconColor: AppColors.blackColor,
        backgroundColor: AppColors.white,
        centerTitle: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                    AppointmentInfoWidget(
                      type: viewModel.type!,
                    ),

                    const AppointmentDurationWidget(),
                    AppointmentPetInfoWidget(
                      onTap: () {
                        //Get.toNamed(Routes.VET_PROFILE);
                        },
                    ),

                    AppointmentPaymentWidget(
                      type: viewModel.subType!,
                    ),

                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                  ],
                ),
              ),
            ),

            Visibility(
              visible: viewModel.subType! == StatusType.pending,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'send_reminder'.tr,
                  borderColor: AppColors.red,
                  color: AppColors.red,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Get.back();
                    Util.showAlert(title: "reminder_has_been_sent");
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
