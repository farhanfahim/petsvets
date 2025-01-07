import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

import '../enums/subscription_type.dart';

class SubscriptionModel {
  int? price;
  String? title;
  String? desc;
  SubscriptionType? type;
  RxBool? isSelected;

  SubscriptionModel({
    this.price,
    this.title,
    this.type,
    this.desc,
    this.isSelected,
  });

}

