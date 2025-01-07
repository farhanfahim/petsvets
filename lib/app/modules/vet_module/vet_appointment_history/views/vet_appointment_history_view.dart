import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../data/enums/status_type.dart';
import '../../../../routes/app_pages.dart';
import '../../my_bookings/widgets/booking_tile.dart';
import '../view_model/vet_appointment_history_view_model.dart';

class VetAppointmentHistoryView extends StatelessWidget {
  final VetAppointmentHistoryViewModel viewModel = Get.put(VetAppointmentHistoryViewModel());

  VetAppointmentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        screenName: "appointment_history".tr,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.arrOfVets.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                BookingTile(
                  model: viewModel.arrOfVets[index],
                  onTap: () {
                    Get.toNamed(Routes.VET_APPOINTMENT_DETAIL,arguments: {
                      ArgumentConstants.type: StatusType.completed
                    });
                  },
                ),

              ],
            );
          },
        ),);
  }
}
