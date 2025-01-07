import 'package:get/get.dart';
import '../../../../firestore/chat_strings.dart';
class VideoViewModel extends GetxController {

  Map<String, dynamic> map = Get.arguments;

  RxString url = "".obs;
  @override
  void onInit() {
    super.onInit();
    if (map[ChatStrings.videoUrl] != null) {
      url.value = map[ChatStrings.videoUrl];
    }
  }

}


