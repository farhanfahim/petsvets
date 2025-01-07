import 'package:get/get.dart';

import '../../../../shared_prefrences/app_prefrences.dart';

class VideoCallViewModel extends GetxController {

  var data = Get.arguments;
  RxString role = "".obs;

  @override
  void onInit() {
    super.onInit();
    role.value = AppPreferences.getRole();
  }


}
