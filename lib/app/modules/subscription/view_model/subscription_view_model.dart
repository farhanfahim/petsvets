import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/utils/constants.dart';

import '../../../data/enums/subscription_type.dart';
import '../../../data/models/subscription_model.dart';


class SubscriptionViewModel extends GetxController {
  final pageController = PageController();
  Rx<int> currentPage = 0.obs;
  RxList<SubscriptionModel> arrOfSubscription = List<SubscriptionModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    arrOfSubscription.add(SubscriptionModel(price: 45,title: "Basic",type:SubscriptionType.basic,desc:Constants.basicPlan,isSelected: false.obs));
    arrOfSubscription.add(SubscriptionModel(price: 45,title: "Choice Benefit",type:SubscriptionType.choiceBenefit,desc:Constants.choiceBenefit,isSelected: false.obs));
    arrOfSubscription.add(SubscriptionModel(price: 50,title: "Premium",type:SubscriptionType.premium,desc:Constants.premium,isSelected: true.obs));
  }

  void changePage(index) {
    pageController.jumpToPage(index);
  }

}
