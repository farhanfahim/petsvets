import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DurationModel {
  String? duration;
  List<TimeSlotModel>? timeSlots;

  DurationModel({
    this.duration,
    this.timeSlots,
  });

}

class TimeSlotModel {
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  RxBool? isSelected;

  TimeSlotModel({
    this.startTime,
    this.endTime,
    this.isSelected,
  });

}

