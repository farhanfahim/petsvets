import 'package:get/get.dart';

import '../view_model/my_profile_view_model.dart';


class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileViewModel>(
      () => MyProfileViewModel(),
    );
  }
}
