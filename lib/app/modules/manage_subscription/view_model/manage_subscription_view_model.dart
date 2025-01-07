import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/utils/constants.dart';
import '../../../data/enums/subscription_type.dart';
import '../../../data/models/subscription_model.dart';


class ManageSubscriptionViewModel extends GetxController {
  SubscriptionModel subscriptionModel = SubscriptionModel();
  RxBool hideCancelBtn = false.obs;
  @override
  void onInit() {
    super.onInit();
    subscriptionModel = SubscriptionModel(price: 45,title: "Basic",type:SubscriptionType.basic,desc:Constants.basicPlan,isSelected: false.obs);
  }


}
