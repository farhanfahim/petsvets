import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../data/models/calender_model.dart';

class DateWidget extends StatelessWidget {

  bool? isFirst;
  CalenderModel? model;
  Function() onTap;
  DateWidget({required this.onTap,this.model,this.isFirst = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap:onTap,
      child: Container(
        width: 65,
        decoration: BoxDecoration(
          color: model!.isSelected!.value?AppColors.lightBlue:AppColors.white,
          border: Border.all(color: model!.isSelected!.value?AppColors.primaryColor:AppColors.gray600.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(AppDimen.dateBorderRadius),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal:AppDimen.contentPadding, vertical:AppDimen.contentPadding),
        margin: const EdgeInsets.only(right:AppDimen.contentSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: DateTimeUtil.formatDateTime(model!.date,
            outputDateTimeFormat: DateTimeUtil.dateTimeFormat8),
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis,
              fontSize: 13,
            ),
            MyText(
              text: isFirst!?"today".tr:DateTimeUtil.formatDateTime(model!.date,
                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat10).toUpperCase(),
              fontWeight: FontWeight.w400,
              color: model!.isSelected!.value?AppColors.primaryColor:AppColors.gray600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 11,
            ),
          ],
        ),
      ),
    ),);
  }
}