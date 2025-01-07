import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class CalenderModel {
  DateTime? date;
  RxBool? isSelected;

  CalenderModel({
    this.date,
    this.isSelected,
  });

}

