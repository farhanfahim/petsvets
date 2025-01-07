import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class AccountSetupViewModel extends GetxController {
  final pageController = PageController();
  Rx<int> currentPage = 0.obs;

  RxInt step1 = 1.obs;
  RxInt step2 = 0.obs;
  RxInt step3 = 0.obs;


  @override
  void onInit() {
    super.onInit();

  }

  void changePage(index) {
    pageController.jumpToPage(index);
    currentPage.refresh();
  }

  void previousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 100), curve:Curves.easeOut);

    currentPage.refresh();
  }

}