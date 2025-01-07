import 'package:get/get.dart';

import '../view_model/chat_view_model.dart';



class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatViewModel>(
      () => ChatViewModel(),
    );
  }
}
