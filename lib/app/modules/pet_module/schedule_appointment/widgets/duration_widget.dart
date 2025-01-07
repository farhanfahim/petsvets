import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/app/data/models/scheduled_model.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../data/models/slot_model.dart';

class DurationWidget extends StatelessWidget {

  Slot? model;
  Function() onTap;
  DurationWidget({required this.onTap,this.model});

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
        padding: const EdgeInsets.symmetric(horizontal:22,  ),
        margin: const EdgeInsets.only(right:AppDimen.contentSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: "${model!.duration!} mins",
              fontWeight: FontWeight.w400,
              color: model!.isSelected!.value?AppColors.primaryColor:AppColors.gray600,
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
            ),
            MyText(
              text: "\$${model!.amount!}",
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 15,
            ),
          ],
        ),
      ),
    ),);
  }
}