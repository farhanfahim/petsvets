import 'package:get/get.dart';
import '../view_model/follow_up_chat_view_model.dart';



class FollowUpChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUpChatViewModel>(
      () => FollowUpChatViewModel(),
    );
  }
}
