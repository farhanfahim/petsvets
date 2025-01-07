import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/dimens.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/calendar_strip/calendar_strip.dart';
import '../../../components/widgets/calendar_strip/calendar_strip_item.dart';
import '../../../components/widgets/custom_dialog.dart';
import '../../../components/widgets/custom_table_calendar.dart';
import '../../../routes/app_pages.dart';
import '../view_model/calender_view_model.dart';
import '../widget/calender_tile.dart';
import '../widget/date_selection_widget.dart';

class CalenderView extends StatelessWidget {
  CalenderView({super.key});

  final CalenderViewModel viewModel = Get.put(CalenderViewModel());

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      horizontalPadding: false,
      verticalPadding: false,
      hasBackButton: false.obs,
      showAppBar: false,
      child: Column(
        children: [
          DateSelectionWidget(
            onTap: () {
              viewModel.calendarOpened.value = !viewModel.calendarOpened.value;
            },
            date: DateTimeUtil.formatDateTime(viewModel.selectedDate.value, outputDateTimeFormat: DateTimeUtil.dateTimeFormat6),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimen.horizontalPadding.w,
              vertical: AppDimen.verticalPadding.h,
            ),
            color: AppColors.chatSenderColor1,
            child: Obx(
                    () => viewModel.calendarOpened.value
                    ? CustomTableCalendar(
                  headerVisible: false,
                  focusedDay: viewModel.selectedDate.value,
                  currentDay: viewModel.selectedDate.value,
                  calendarFormat: viewModel.format.value,
                  rowHeight: 40,
                  markedDates: [DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-2),DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+2),DateTime.now()],
                  onFormatChanged: (format) {
                    print("Format changed -> $format");
                    // viewModel.format.value = format;
                  },
                  onPageChanged: (focusedDay) {
                    print("onPageChanged: Focused day: $focusedDay");

                    viewModel.selectedDate.value = focusedDay;
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(viewModel.selectedDate.value, day);
                  },
                  // enabledDayPredicate: (eventDate){
                  //   return isSameDay(DateTime.now(), eventDate);
                  // },
                  onDaySelected: (selectedDay, focusedDay) {
                    // print("onDaySelected: Old selected day: $_selectedDay Selected day: $selectedDay Focused day: $focusedDay");

                    if (!isSameDay(viewModel.selectedDate.value, selectedDay)) {
                      viewModel.selectedDate.value = selectedDay;
                    }
                  },
                )
                    : CalendarStrip(
                  addSwipeGesture: false,
                  enablePastDates: false,
                  currentDate: viewModel.selectedDate.value,
                  onDateSelected: (dateTime) {
                    viewModel.selectedDate.value = dateTime;
                  },
                  dateTileBuilder: dateTileBuilder,
                ),
              ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.arrOfVets.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CalenderTile(
                      model: viewModel.arrOfVets[index],
                      onTap: () {
                        if(viewModel.role.value == Constants.rolePet){
                          Get.toNamed(Routes.APPOINTMENT_DETAIL,arguments: {
                            ArgumentConstants.type: viewModel.arrOfVets[index].type
                          });
                        }else{

                          Get.toNamed(Routes.VET_APPOINTMENT_DETAIL,arguments: {
                            ArgumentConstants.type: viewModel.arrOfVets[index].type
                          });

                          Timer(const Duration(seconds: 2), () {

                            showDialog(
                                context: Get.context!,
                                builder: (ct) {
                                  return CustomDialogue(
                                    image: AppImages.bell,
                                    isSingleButton: true,
                                    dialogueBoxHeading: "reminder".tr,
                                    dialogueBoxText: "you_have_a_30_min".tr,

                                    actionOnYes: () {
                                      Get.back();
                                    },
                                    actionOnNo: (){},
                                    yesText: "okay".tr,
                                  );
                                });

                          });



                        }

                      },
                    ),
                    Visibility(
                        visible:viewModel.arrOfVets.length-1 == index,
                        child: const SizedBox(height: 10,))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;

    return CalendarStripItem(
      day: date,
      selected: isSelectedDate,
      showDot: false,
    );
  }
}
