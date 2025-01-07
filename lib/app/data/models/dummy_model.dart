import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class DummyModel {
  String? id;
  String? image;
  String? title;
  AccountType? type;
  String? subTitle;
  RxBool? isSelected;

  DummyModel({
    this.id,
    this.image,
    this.title,
    this.type,
    this.subTitle,
    this.isSelected,
  });

}

