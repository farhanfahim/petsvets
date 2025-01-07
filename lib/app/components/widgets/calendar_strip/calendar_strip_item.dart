import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/dot.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class CalendarStripItem extends StatelessWidget {
  const CalendarStripItem({
    super.key,
    required this.day,
    required this.selected,
    this.showDot = false,
  });

  final DateTime day;
  final bool selected;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5,),
          MyText(
            text: DateTimeUtil.formatDateTime(day, outputDateTimeFormat: DateTimeUtil.dateTimeFormat7),
            color: selected ? AppColors.white : AppColors.gray600,
            fontSize: AppFontSize.extraSmall,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 10,),
          MyText(
            text: DateTimeUtil.formatDateTime(day, outputDateTimeFormat: DateTimeUtil.dateTimeFormat8),
            color: selected ? AppColors.white : AppColors.black,
            fontSize: AppFontSize.extraSmall,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 5,),

          if (showDot)
            Dot(
              color: selected ? AppColors.white : AppColors.black,
            ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
