import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class PetTypeModel {
  String? title;
  RxString? breed;
  RxBool? isSelected;

  PetTypeModel({
    this.title,
    this.breed,
    this.isSelected,
  });

}

