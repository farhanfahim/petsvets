import 'package:get/get.dart';

import '../view_model/video_call_view_model.dart';


class VideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoCallViewModel>(
      () => VideoCallViewModel(),
    );
  }
}
