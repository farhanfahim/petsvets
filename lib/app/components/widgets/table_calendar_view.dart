import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'dart:math' as math;
import 'package:table_calendar/table_calendar.dart';
import '../resources/app_fonts.dart';
import 'MyText.dart';

class TableCalendarView extends StatefulWidget {
  final void Function(DateTime)? onSelectDate;
  final void Function(TimeOfDay)? onSelectTime;

  final bool isShowTime;

  final DateTime? selectedDate;
  final double? height;
  final bool pastDateEnabled, futureDatesEnabled, dateOfBirth;
  final TimeOfDay? selectedTime;
  final bool isUseExpanded;

  const TableCalendarView({
    super.key,
    this.onSelectDate,
    this.onSelectTime,
    this.isShowTime = false,
    this.selectedTime,
    this.pastDateEnabled = true,
    this.dateOfBirth = false,
    this.futureDatesEnabled = true,
    this.isUseExpanded = true,
    this.selectedDate,
    this.height,
  });

  @override
  State<TableCalendarView> createState() => _TableCalendarView2State();
}

class _TableCalendarView2State extends State<TableCalendarView> {
  bool _showMonths = false;

  late DateTime _focusedDay;

  late DateTime _selectedDate;

  late DateTime _firstDate;
  late DateTime _lastDate;

  late TimeOfDay selectedTime;

  @override
  void initState() {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    _firstDate = widget.pastDateEnabled ? DateTime(1940, 10, 16) : today;
    _lastDate = widget.futureDatesEnabled ? DateTime(2030, 3, 14) : today;
    selectedTime = widget.selectedTime ?? TimeOfDay.now();
    if (widget.selectedDate != null) {
      if ((widget.selectedDate!.isAfter(_firstDate) ||
              dateEqual(widget.selectedDate!, _firstDate)) &&
          (widget.selectedDate!.isBefore(_lastDate) ||
              dateEqual(widget.selectedDate!, _lastDate))) {
        _selectedDate = DateTime(widget.selectedDate!.year,
            widget.selectedDate!.month, widget.selectedDate!.day);
      } else {
        _selectedDate = today;
      }
    } else {
      _selectedDate = widget.dateOfBirth
          ? DateTime(now.year - 18, now.month, now.day)
          : today;
    }
    _focusedDay = _selectedDate;
    widget.onSelectDate?.call(_selectedDate);
    super.initState();
  }

  bool dateEqual(DateTime dateTime1, DateTime dateTime2) {
    return (dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day);
  }

  @override
  Widget build(BuildContext context) {
    final Color weekDayColor = AppColors.grey.withOpacity(0.3);
    const defaultColor = AppColors.black;
    const double weekDayFontSize = 12;
    const double defaultFontSize = 18;
    const FontWeight defaultFontWeight = FontWeight.w400, weekFontWeight = FontWeight.w500;
    const String fontFamily = AppFonts.fontMulish;

    const double radius = 0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius)),
      child: !_showMonths
          ? Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildHeader(),
                  Expanded(
                    flex: widget.isUseExpanded ? 1 : 0,
                    child: SizedBox(
                      height: widget.height,
                      child: TableCalendar(
                        calendarFormat: CalendarFormat.month,
                        firstDay: _firstDate,
                        lastDay: _lastDate,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (dateTime) {
                          return dateEqual(_selectedDate, dateTime);
                        },
                        availableGestures: AvailableGestures.none,
                        onDaySelected: _onDaySelected,
                        onHeaderTapped: (dateTime) {
                          setState(() {
                            _showMonths = true;
                          });
                        },
                        headerVisible: false,
                        weekNumbersVisible: false,
                        shouldFillViewport: true,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                                color: weekDayColor,
                                fontSize: weekDayFontSize,
                                fontFamily: fontFamily,
                                fontWeight: weekFontWeight),
                            weekendStyle: TextStyle(
                                color: weekDayColor,
                                fontSize: weekDayFontSize,
                                fontFamily: fontFamily,
                                fontWeight: weekFontWeight),
                            dowTextFormatter: (date, locale) {
                              return DateFormat('EEE').format(date).toUpperCase();
                            }),
                        calendarStyle: CalendarStyle(
                          cellPadding: const EdgeInsets.all(3),
                          cellMargin: const EdgeInsets.all(3),
                          cellAlignment: Alignment.center,
                          defaultTextStyle: const TextStyle(
                            color: defaultColor,
                            fontSize: defaultFontSize,
                            fontWeight: defaultFontWeight,
                            fontFamily: fontFamily,
                          ),
                          outsideDaysVisible: false,
                          disabledTextStyle: TextStyle(
                              color: weekDayColor,
                              fontSize: defaultFontSize,
                              fontWeight: defaultFontWeight,
                              fontFamily: fontFamily),
                          weekendTextStyle: const TextStyle(
                              color: defaultColor,
                              fontSize: defaultFontSize,
                              fontWeight: defaultFontWeight,
                              fontFamily: fontFamily),
                          selectedTextStyle: const TextStyle(
                              color: AppColors.white,
                              fontSize: defaultFontSize,
                              fontWeight: defaultFontWeight,
                              fontFamily: fontFamily),
                          todayTextStyle: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: defaultFontSize,
                              fontWeight: defaultFontWeight,
                              fontFamily: fontFamily),
                          rowDecoration: const BoxDecoration(color: AppColors.transparent),
                          defaultDecoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.transparent),
                          holidayDecoration: const BoxDecoration(color: AppColors.transparent),
                          weekendDecoration: const BoxDecoration(color: AppColors.transparent),
                          selectedDecoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle),
                          withinRangeDecoration: const BoxDecoration(color: AppColors.transparent),
                          outsideDecoration: const BoxDecoration(color: AppColors.transparent),
                          rangeStartDecoration: const BoxDecoration(color: AppColors.transparent),
                          rangeEndDecoration: const BoxDecoration(color: AppColors.transparent),
                          markerDecoration: const BoxDecoration(color: AppColors.transparent),
                          todayDecoration: const BoxDecoration(color: AppColors.transparent),
                          markerSizeScale: 0,
                          markerSize: 0,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          : Builder(builder: (context) {
            return MonthPicker.single(
              selectedDate: _focusedDay,
              datePickerStyles: DatePickerStyles(
                selectedSingleDateDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.all( Radius.circular(10.0),
                    ),
                    color: AppColors.primaryColor),
              ),
              onChanged: _onFocusDateChanged,
              firstDate: _firstDate,
              lastDate: _lastDate,
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                monthPickerPortraitWidth: double.maxFinite,
              ),
            );
          }),
    );
  }


  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _showMonths = true;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
            child: Row(
              children: [
                MyText(
                  text: DateFormat('MMMM yyyy').format(_focusedDay),
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 16,
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  swipeCalendar(false);
                },
                child: Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: const CommonImageView(
                    svgPath: AppImages.arrowLeft,
                  ),
                )
              ),
              GestureDetector(
                onTap: () {
                  swipeCalendar(true);
                },
                child: const CommonImageView(
                  svgPath: AppImages.arrowLeft,
                )
              ),
            ],
          ),
        ),
      ],
    );
  }

  void swipeCalendar(bool forward) {
    if (forward) {
       DateTime newDate = DateTime(
        _focusedDay.year,
        _focusedDay.month + 1,
      );
      if ((newDate.isBefore(_lastDate) || dateEqual(newDate, _lastDate))) {
        _onFocusDateChanged(newDate);
      }
    } else {
      DateTime newDate = DateTime(
        _focusedDay.year,
        _focusedDay.month - 1,
      );
      if ((newDate.isAfter(_firstDate) || dateEqual(newDate, _firstDate))) {
        _onFocusDateChanged(newDate);
      }
    }

  }

  void _onFocusDateChanged(DateTime newDate) {
    setState(() {
      _focusedDay = newDate;
      _showMonths = false;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print("date selected: $selectedDay");
    print("date focused: $focusedDay");
    setState(() {
      _selectedDate = selectedDay;
      widget.onSelectDate?.call(_selectedDate);
    });
    //}
  }
}
