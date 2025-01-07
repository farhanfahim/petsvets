import 'package:get/get.dart';
import '../view_model/current_chat_view_model.dart';



class CurrentChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrentChatViewModel>(
      () => CurrentChatViewModel(),
    );
  }
}
