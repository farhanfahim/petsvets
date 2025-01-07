import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class SettingModel {
  String? image;
  String? title;
  RxBool? isSelected;

  SettingModel({
    this.image,
    this.title,
    this.isSelected,
  });

}

