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

class StatisticsWidget extends StatelessWidget {

  String? title;
  String? subTitle;
  Function() onTap;
  StatisticsWidget({required this.onTap,this.title,this.subTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: title!,
            fontWeight: FontWeight.w800,
            color: AppColors.black,
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
          ),
          MyText(
            text: subTitle!,
            fontWeight: FontWeight.w500,
            color: AppColors.gray600,
            overflow: TextOverflow.ellipsis,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

}