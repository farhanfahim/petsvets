import 'package:get/get.dart';
import '../view_model/success_view_model.dart';

class SuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessViewModel>(
      () => SuccessViewModel(),
    );
  }
}
