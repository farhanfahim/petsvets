import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/app_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({
    super.key,
    required this.focusedDay,
    this.currentDay,
    this.firstDay,
    this.lastDay,
    required this.calendarFormat,
    this.onPageChanged,
    this.selectedDayPredicate,
    this.onDaySelected,
    this.onFormatChanged,
    this.headerVisible = true,
    this.rowHeight = 40,
    this.boxShape = BoxShape.circle,
    this.outsideDaysVisible = true,
    this.pastDateEnabled = false,
    this.futureDatesEnabled = true,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.markedDates,
  });

  final bool headerVisible;
  final bool outsideDaysVisible;
  final bool pastDateEnabled;
  final bool futureDatesEnabled;
  final double rowHeight;
  final DateTime focusedDay;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final DateTime? currentDay;
  final List<DateTime>? markedDates;
  final CalendarFormat calendarFormat;
  final BoxShape boxShape;
  final TextStyle? dayTextStyle;
  final TextStyle? selectedDayTextStyle;
  final void Function(DateTime)? onPageChanged;
  final bool Function(DateTime)? selectedDayPredicate;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(CalendarFormat)? onFormatChanged;

  @override
  Widget build(BuildContext context) {
    var textStyle = dayTextStyle ?? AppTextStyles.calendarDayText();

    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        singleMarkerBuilder: (context, date, _) => Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: isSameDay(date, currentDay) ? AppColors.white : AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
      firstDay: pastDateEnabled ? DateTime(1900, 01, 01) : firstDay ?? DateTime.now(),
      lastDay: futureDatesEnabled ? lastDay ?? DateTime(2050, 12, 31) : DateTime.now(),

      focusedDay: focusedDay,
      currentDay: currentDay,

      ///Styling
      rowHeight: rowHeight,
      headerVisible: headerVisible,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: AppTextStyles.calendarHeaderText(),
        formatButtonVisible: false,
        leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.blackColor),
        rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.blackColor),
      ),
      daysOfWeekHeight: 30,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: AppTextStyles.calendarWeekDay(),
        weekendStyle: AppTextStyles.calendarWeekDay(),
      ),
      calendarFormat: calendarFormat,
      calendarStyle: CalendarStyle(
        markersAnchor: 1.5,
        markerSize: 5,
        // markerDecoration: BoxDecoration(
        // color: isSameDay(focusedDay, currentDay) ? AppColors.white : AppColors.primaryColor,
        // shape: BoxShape.circle,
        // ),
        cellMargin: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 2,
          bottom: 2
        ),

        todayDecoration: ShapeDecoration(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        selectedDecoration: ShapeDecoration(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        selectedTextStyle: selectedDayTextStyle ?? AppTextStyles.calendarSelectedDay(),
        weekendTextStyle: textStyle,
        defaultTextStyle: textStyle,
        outsideTextStyle: AppTextStyles.calendarOutside(),
        disabledTextStyle: AppTextStyles.calendarOutside(),
        outsideDaysVisible: outsideDaysVisible,
      ),

      ///Callbacks
      onFormatChanged: onFormatChanged,
      selectedDayPredicate: selectedDayPredicate,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      eventLoader: (date) {
        if (markedDates != null) {
          bool contains = false;

          for (var markDate in markedDates!) {
            contains = isSameDay(date, markDate);
            if (contains) return [""];
          }
        }

        return [];
      },
    );
  }
}

class CalendarWidget extends StatefulWidget {
  final bool pastDateEnabled, futureDatesEnabled;
  final void Function(DateTime dateTime)? onDateSelect;
  final void Function(DateTime dateTime)? onPageChanged;
  final DateTime? selectedDate;
  final double height;
  final bool headerVisible;

  const CalendarWidget({
    Key? key,
    this.pastDateEnabled = true,
    this.futureDatesEnabled = true,
    this.onDateSelect,
    this.onPageChanged,
    this.selectedDate,
    this.headerVisible = true,
    required this.height,
  }) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  bool _showMonths = false;

  late DateTime _focusedDay;

  late DateTime _selectedDate;

  late DateTime _firstDate;
  late DateTime _lastDate;

  @override
  void initState() {
    print("calendar init called");
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    _firstDate = widget.pastDateEnabled ? DateTime(1940, 10, 16) : today;
    _lastDate = widget.futureDatesEnabled ? DateTime(2030, 3, 14) : today;

    if (widget.selectedDate != null) {
      if ((widget.selectedDate!.isAfter(_firstDate) || dateEqual(widget.selectedDate!, _firstDate)) &&
          (widget.selectedDate!.isBefore(_lastDate) || dateEqual(widget.selectedDate!, _lastDate))) {
        _selectedDate = widget.selectedDate!;
      } else {
        _selectedDate = today;
      }
    } else {
      _selectedDate = today;
    }
    _focusedDay = _selectedDate;
    //widget.onDateSelect?.call(_selectedDate);
    super.initState();
  }

  bool dateEqual(DateTime dateTime1, DateTime dateTime2) {
    return (dateTime1.year == dateTime2.year && dateTime1.month == dateTime2.month && dateTime1.day == dateTime2.day);
  }

  @override
  Widget build(BuildContext context) {
    // var media=MediaQuery.of(context).size;
    final Color weekDayColor = AppColors.grey, defaultColor = AppColors.black;
    final double weekDayFontSize = 14;
    final double defaultFontSize = 16;
    const FontWeight defaultFontWeight = FontWeight.w600, weekFontWeight = FontWeight.w600;
    const String fontFamily = AppFonts.fontMulish;

    final double radius = 5;
    //const double radius=0;

    return !_showMonths
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(),
              SizedBox(height: 6),
              SizedBox(
                //height: AppSizer.getVerticalSize(237),
                height: widget.height,
                child: TableCalendar(
                  firstDay: _firstDate,
                  lastDay: _lastDate,
                  //focusedDay: _focusedDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (dateTime) {
                    // return dateEqual(_focusedDay,dateTime);
                    return dateEqual(_selectedDate, dateTime);
                  },
                  availableGestures: AvailableGestures.all,
                  // eventLoader: _getEventsForDay,
                  onDaySelected: _onDaySelected,
                  onHeaderTapped: (dateTime) {
                    setState(() {
                      _showMonths = true;
                    });
                  },
                  headerVisible: false,
                  weekNumbersVisible: false,
                  shouldFillViewport: true,
                  onPageChanged: (dateTime) {
                    setState(() {
                      _focusedDay = dateTime;
                    });
                    widget.onPageChanged?.call(dateTime);
                  },
                  //calendarBuilders: CalendarBuilders(),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: weekDayColor, fontSize: weekDayFontSize, fontFamily: fontFamily, fontWeight: weekFontWeight),
                      weekendStyle: TextStyle(color: weekDayColor, fontSize: weekDayFontSize, fontFamily: fontFamily, fontWeight: weekFontWeight),
                      dowTextFormatter: (date, locale) {
                        return DateFormat('EEE').format(date).toUpperCase();
                      }),
                  //            formatAnimationDuration: const Duration(seconds: 0),
                  // pageAnimationDuration: const Duration(seconds: 0),
                  calendarStyle: CalendarStyle(
                    cellPadding: EdgeInsets.zero,
                    cellMargin: EdgeInsets.zero,
                    cellAlignment: Alignment.center,
                    defaultTextStyle: TextStyle(
                      color: defaultColor,
                      fontSize: defaultFontSize,
                      fontWeight: defaultFontWeight,
                      fontFamily: fontFamily,
                    ),
                    outsideDaysVisible: true,
                    disabledTextStyle:
                        TextStyle(color: weekDayColor, fontSize: defaultFontSize, fontWeight: defaultFontWeight, fontFamily: fontFamily),
                    weekendTextStyle:
                        TextStyle(color: defaultColor, fontSize: defaultFontSize, fontWeight: defaultFontWeight, fontFamily: fontFamily),
                    selectedTextStyle:
                        TextStyle(color: AppColors.white, fontSize: defaultFontSize, fontWeight: defaultFontWeight, fontFamily: fontFamily),
                    todayTextStyle: TextStyle(
                        //color: AppColor.white,
                        color: defaultColor,
                        fontSize: defaultFontSize,
                        fontWeight: defaultFontWeight,
                        fontFamily: fontFamily),
                    rowDecoration: const BoxDecoration(color: AppColors.transparent),
                    defaultDecoration: const BoxDecoration(color: AppColors.transparent),
                    holidayDecoration: const BoxDecoration(color: AppColors.transparent),
                    weekendDecoration: const BoxDecoration(color: AppColors.transparent),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    withinRangeDecoration: const BoxDecoration(color: AppColors.transparent),
                    outsideDecoration: const BoxDecoration(color: AppColors.transparent),
                    rangeStartDecoration: const BoxDecoration(color: AppColors.transparent),
                    rangeEndDecoration: const BoxDecoration(color: AppColors.transparent),
                    markerDecoration: const BoxDecoration(color: AppColors.transparent),
                    todayDecoration: const BoxDecoration(color: AppColors.transparent),
                    /*        todayDecoration: BoxDecoration(
                //color: AppColor.primary1.withOpacity(0.5),
                color: AppColor.transparent,borderRadius: BorderRadius.circular(radius),
                shape: BoxShape.rectangle),*/
                    markerSizeScale: 0,
                    markerSize: 0,
                  ),
                ),
              ),
            ],
          )
        : Container(
            child: MonthPicker.single(
              //selectedDate: _selectedDate,
              datePickerStyles: DatePickerStyles(
                  currentDateStyle: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                  selectedSingleDateDecoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10))),
              selectedDate: _focusedDay,
              onChanged: _onFocusDateChanged,
              firstDate: _firstDate,
              lastDate: _lastDate,
              datePickerLayoutSettings: const DatePickerLayoutSettings(
                monthPickerPortraitWidth: double.maxFinite,
              ),
              //   datePickerStyles: styles,
            ),
          );
  }

  Widget buildHeader() {
    final double iconsize = 15;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showMonths = true;
              });
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                MyText(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  //fontFamily: FontFamily.PRIMARY,
                  text: DateFormat('MMMM yyyy').format(_focusedDay),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  //swipeCalendar(false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: iconsize,
                    color: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                width: 3.0,
              ),
              InkWell(
                onTap: () {
                  //swipeCalendar(true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: iconsize,
                    color: AppColors.transparent,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void swipeCalendar(bool forward) {
    if (forward) {
      //DateTime newDate = new DateTime(_focusedDay.year, _focusedDay.month + 1,_focusedDay.day);
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

    print("focused date: ${_focusedDay}");
  }

  void _onFocusDateChanged(DateTime newDate) {
    setState(() {
      //_selectedDate = newDate;
      _focusedDay = newDate;
      _showMonths = false;
      widget.onPageChanged?.call(_focusedDay);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    var futureDateSelected = selectedDay.isAfter(DateTime.now().subtract(const Duration(days: 1)));

    if (!widget.pastDateEnabled && !futureDateSelected) {
      Util.showToast("Please select current or future date");
      return;
    }

    print("date selected: $selectedDay");
    print("date focused: $focusedDay");
    // if (!isSameDay(_selectedDay, selectedDay)) {
    setState(() {
      _selectedDate = selectedDay;
      //  _focusedDay=focusedDay;
      widget.onDateSelect?.call(_selectedDate);
    });
    //}
  }
}
