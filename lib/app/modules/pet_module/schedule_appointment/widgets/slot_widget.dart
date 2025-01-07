import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/models/duration_model.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../data/models/calender_model.dart';

class SlotWidget extends StatelessWidget {

  TimeSlotModel? model;
  Function() onTap;
  SlotWidget({required this.onTap,this.model});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          color: model!.isSelected!.value?AppColors.lightBlue:AppColors.white,
          border: Border.all(color: model!.isSelected!.value?AppColors.primaryColor:AppColors.gray600.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(AppDimen.dateBorderRadius),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal:AppDimen.contentPadding),
        child: Center(
          child: MyText(
            text: '${formatTimeOfDay(model!.startTime!)} - ${formatTimeOfDay(model!.endTime!)}',
            fontWeight: model!.isSelected!.value?FontWeight.w600:FontWeight.w400,
            color: model!.isSelected!.value?AppColors.primaryColor:AppColors.gray600,
            overflow: TextOverflow.ellipsis,
            fontSize: 14,
          ),
        ),
      ),
    ),);
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  // you can use 'jm' for AM/PM format
    return format.format(dt);
  }
}