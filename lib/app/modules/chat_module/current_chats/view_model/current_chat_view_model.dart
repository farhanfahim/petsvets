import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../data/models/dummy_appointment_model.dart';
import '../../../../data/models/user_model.dart';
import '../../chat/view_model/chat_view_model.dart';

class CurrentChatViewModel extends GetxController with GetTickerProviderStateMixin{
  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;
  RxList<DummyAppointmentModel> arrOfVetsSearch = List<DummyAppointmentModel>.empty().obs;

  final ChatViewModel chatViewController = Get.find();

  TabController? tabController;

  RxList<String> tabs = [
    'currentChats'.tr,
    'followUp'.tr,
  ].obs;

  Rx<UserModel> userModel = UserModel().obs;
  RxInt? read;
  RxInt? userId;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);

    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      userId = userModel.value.user!.id!.obs;
      userId!.refresh();
    });
  }




  getGroupReadStatus(List<dynamic> readData){

    var value = readData.where((e) => e['id'] ==  userId!.value && e['is_read'] == false);
    if(value.isNotEmpty){
      read = 1.obs;
    }else{
      read = 0.obs;
    }

    print(read);
    return read;
  }
}
