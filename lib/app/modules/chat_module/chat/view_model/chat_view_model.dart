import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/utils/Util.dart';

import '../../../../data/models/dummy_appointment_model.dart';

class ChatViewModel extends GetxController with GetTickerProviderStateMixin{
  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  TabController? tabController;

  RxList<String> tabs = [
    'currentChats'.tr,
    'followUp'.tr,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);

    tabController!.addListener((){
      Util.hideKeyBoard(Get.context!);
    });

  }

}
