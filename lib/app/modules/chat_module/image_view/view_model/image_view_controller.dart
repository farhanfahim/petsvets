import 'package:get/get.dart';
import '../../../../firestore/chat_strings.dart';

class ImageViewModel extends GetxController {

  RxString imageUrl = "".obs;
  Map<String, dynamic> map = Get.arguments;

  @override
  void onReady() {
    super.onReady();
    if (map[ChatStrings.imageUrl] != null) {
      imageUrl.value = map[ChatStrings.imageUrl];
    }
  }

}


