import 'package:flutter/cupertino.dart';

class SelectTimeModel {
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? endTimeController = TextEditingController();
  DateTime? startSelectedTime;
  DateTime? endSelectedTime;

  SelectTimeModel({
    this.startTimeController,
    this.endTimeController,
    this.startSelectedTime,
    this.endSelectedTime,
  });

}

