import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class CalendarStrip extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final Function(DateTime, DateTime, int, String, bool, bool)? dateTileBuilder;
  final BoxDecoration? containerDecoration;
  final DateTime? selectedDate;
  final DateTime? currentDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<DateTime>? markedDates;
  final bool? addSwipeGesture;
  final bool enablePastDates;

  const CalendarStrip({
    super.key,
    this.addSwipeGesture = false,
    @required this.onDateSelected,
    this.dateTileBuilder,
    this.currentDate,
    this.containerDecoration,
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.markedDates,
    this.enablePastDates = true,
  });

  @override
  State<CalendarStrip> createState() => CalendarStripState(selectedDate, startDate, endDate, currentDate);
}

class CalendarStripState extends State<CalendarStrip> with TickerProviderStateMixin {
  DateTime? currentDate;
  DateTime? selectedDate;
  DateTime? rowStartingDate;
  bool? isOnEndingWeek = false, isOnStartingWeek = false;
  bool? doesDateRangeExists = false;

  List<String> dayLabels = [
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Sa",
    "Su",
  ];

  CalendarStripState(DateTime? selectedDate, DateTime? startDate, DateTime? endDate, DateTime? currentDate) {
    this.currentDate = currentDate ?? DateTime.now();
    _runPresetsAndExceptions(selectedDate, startDate, endDate);

    this.selectedDate = currentDate;
  }

  void _runPresetsAndExceptions(DateTime? selectedDate, DateTime? startDate, DateTime? endDate) {
    if ((startDate == null && endDate != null) || (startDate != null && endDate == null)) {
      throw Exception("Both 'startDate' and 'endDate' are mandatory to specify range");
    } else if (selectedDate != null && (DateTimeUtil.isDateBefore(selectedDate, startDate) || DateTimeUtil.isDateAfter(selectedDate, endDate))) {
      throw Exception("Selected Date is out of range from start and end dates");
    } else if (startDate == null && startDate == null) {
      doesDateRangeExists = false;
    } else {
      doesDateRangeExists = true;
    }
    if (doesDateRangeExists!) {
      if (endDate != null && DateTimeUtil.isDateAfter(currentDate, endDate)) {
        currentDate = DateTimeUtil.getDateOnly(startDate!);
      } else if (DateTimeUtil.isDateBefore(currentDate, startDate)) {
        currentDate = DateTimeUtil.getDateOnly(startDate!);
      }
    }
    if (selectedDate != null) {
      currentDate = DateTimeUtil.getDateOnly(_nullOrDefault(selectedDate, currentDate));
    }
  }

  @override
  void initState() {
    super.initState();

    rowStartingDate = rowStartingDate ?? currentDate!.subtract(Duration(days: currentDate!.weekday - 1));
    var dateRange = calculateDateRange(null);
    setState(() {
      isOnEndingWeek = dateRange['isEndingWeekOnRange'];
      isOnStartingWeek = dateRange['isStartingWeekOnRange'];
    });
  }

  bool _isDateMarked(DateTime date) {
    date = DateTimeUtil.getDateOnly(date);
    bool isDateMarked = false;
    if (widget.markedDates != null) {
      for (var eachMarkedDate in widget.markedDates!) {
        if (DateTimeUtil.getDateOnly(eachMarkedDate) == date) {
          isDateMarked = true;
        }
      }
    }
    return isDateMarked;
  }

  Map<String, bool> calculateDateRange(mode) {
    if (doesDateRangeExists!) {
      DateTime nextRowStartingDate;
      DateTime weekStartingDate, weekEndingDate;
      if (mode != null) {
        nextRowStartingDate = mode == "PREV" ? rowStartingDate!.subtract(const Duration(days: 7)) : rowStartingDate!.add(const Duration(days: 7));
      } else {
        nextRowStartingDate = rowStartingDate!;
      }
      weekStartingDate = DateTimeUtil.getDateOnly(nextRowStartingDate);
      weekEndingDate = DateTimeUtil.getDateOnly(nextRowStartingDate.add(const Duration(days: 6)));
      bool isStartingWeekOnRange = DateTimeUtil.isDateAfter(widget.startDate, weekStartingDate);
      bool isEndingWeekOnRange = DateTimeUtil.isDateBefore(widget.endDate, weekEndingDate);
      return {"isEndingWeekOnRange": isEndingWeekOnRange, "isStartingWeekOnRange": isStartingWeekOnRange};
    } else {
      return {"isEndingWeekOnRange": false, "isStartingWeekOnRange": false};
    }
  }

  void _onPrevRow() {
    var dateRange = calculateDateRange("PREV");
    setState(() {
      rowStartingDate = rowStartingDate!.subtract(const Duration(days: 7));
      isOnEndingWeek = dateRange['isEndingWeekOnRange'];
      isOnStartingWeek = dateRange['isStartingWeekOnRange'];
    });
  }

  void _onNextRow() {
    var dateRange = calculateDateRange("NEXT");
    setState(() {
      rowStartingDate = rowStartingDate!.add(const Duration(days: 7));
      isOnEndingWeek = dateRange['isEndingWeekOnRange'];
      isOnStartingWeek = dateRange['isStartingWeekOnRange'];
    });
  }

  void _onDateTap(DateTime date) {
    var futureDateSelected = date.isAfter(DateTime.now().subtract(const Duration(days: 1)));

    if (!widget.enablePastDates && !futureDateSelected) {
      Util.showToast("Please select current or future date");
      return;
    }

    if (!doesDateRangeExists!) {
      setState(() {
        selectedDate = date;
        widget.onDateSelected!(date);
      });
    } else if (!DateTimeUtil.isDateAfter(date, widget.endDate)) {
      setState(() {
        selectedDate = date;
        widget.onDateSelected!(date);
      });
    } else {}
  }

  _nullOrDefault(var normalValue, var defaultValue) {
    if (normalValue == null) {
      return defaultValue;
    }
    return normalValue;
  }

  bool _checkOutOfRangeStatus(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    if (widget.startDate != null && widget.endDate != null) {
      if (!DateTimeUtil.isDateAfter(date, widget.endDate)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void _onStripDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0 || !widget.addSwipeGesture!) return;
    if (details.primaryVelocity! < 0) {
      if (!isOnEndingWeek!) {
        _onNextRow();
      }
    } else {
      if (!isOnStartingWeek!) {
        _onPrevRow();
      }
    }
  }

  _buildDateRow() {
    List<Widget> currentWeekRow = [];
    for (var eachDay = 0; eachDay < 7; eachDay++) {
      var index = eachDay;
      currentWeekRow.add(_dateTileBuilder(rowStartingDate!.add(Duration(days: eachDay)), selectedDate!, index));
    }
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) => _onStripDrag(details),
      child: Row(children: currentWeekRow),
    );
  }

  Widget _dateTileBuilder(DateTime date, DateTime selectedDate, int rowIndex) {
    bool isDateOutOfRange = _checkOutOfRangeStatus(date);
    String dayName = dayLabels[date.weekday - 1];
    if (widget.dateTileBuilder != null) {
      return Expanded(
        child: SlideFadeTransition(
          delay: 30 + (30 * rowIndex),
          id: "${date.day}${date.month}${date.year}",
          curve: Curves.ease,
          child: GestureDetector(
            onTap: () => _onDateTap(date),
            child: Container(
              child: widget.dateTileBuilder!(date, selectedDate, rowIndex, dayName, _isDateMarked(date), isDateOutOfRange),
            ),
          ),
        ),
      );
    }

    return SlideFadeTransition(
      delay: 30 + (30 * rowIndex),
      id: "${date.day}${date.month}${date.year}",
      curve: Curves.ease,
      child: GestureDetector(
        onTap: () => _onDateTap(date),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
          child: Column(
            children: [
              MyText(
                text: dayLabels[date.weekday - 1],
                color: Colors.black,
                fontFamily: AppFonts.fontMulish,
              ),
              MyText(
                text: date.day.toString(),
                fontSize: AppFontSize.extraSmall,
                color: Colors.black,
                fontFamily: AppFonts.fontMulish,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Container(
      child: _buildDateRow(),
      decoration: widget.containerDecoration,
    );
  }
}

class SlideFadeTransition extends StatefulWidget {
  final Widget child;
  final int? delay;
  final String id;
  final Curve? curve;

  const SlideFadeTransition({
    super.key,
    required this.child,
    required this.id,
    this.delay,
    this.curve,
  });

  @override
  SlideFadeTransitionState createState() => SlideFadeTransitionState();
}

class SlideFadeTransitionState extends State<SlideFadeTransition> with TickerProviderStateMixin {
  AnimationController? _animController;
  Animation<Offset>? _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    final curve = CurvedAnimation(curve: widget.curve ?? Curves.decelerate, parent: _animController!);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(curve);

    if (widget.delay == null) {
      _animController!.forward();
    } else {
      _animController!.reset();
      Future.delayed(Duration(milliseconds: widget.delay!), () {
        _animController!.forward();
      });
    }
  }

  @override
  void didUpdateWidget(SlideFadeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _animController!.reset();
      Future.delayed(Duration(milliseconds: widget.delay!), () {
        _animController!.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController!,
      child: SlideTransition(position: _animOffset!, child: widget.child),
    );
  }
}
