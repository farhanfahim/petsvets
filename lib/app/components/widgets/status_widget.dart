import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../data/enums/status_type.dart';
import '../../data/models/pet_type_model.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';
import 'common_image_view.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget(this.type, {super.key});

  final StatusType type;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: type == StatusType.pending
            ? AppColors.statusPending.withOpacity(0.2)
            : type == StatusType.cancelled
                ? AppColors.statusCancelled.withOpacity(0.2)
            : type == StatusType.paid
            ? AppColors.statusPaid
                : AppColors.statusPaid,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimen.dateBorderRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
          vertical: 4),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: MyText(
          center: true,
          text: type == StatusType.pending
              ? "pending".tr
              : type == StatusType.cancelled
              ? "cancelled".tr
              : type == StatusType.completed
              ? "completed".tr
              : type == StatusType.paid
              ? "paid".tr
              : "confirmed".tr,
          fontWeight: FontWeight.w500,
          color: type == StatusType.pending
              ? AppColors.statusPending
              : type == StatusType.cancelled
              ? AppColors.statusCancelled
              : type == StatusType.paid
              ? AppColors.statusConfirmed
              : AppColors.statusConfirmed,
          fontSize: 12,
        ),
      ),
    );
  }
}
