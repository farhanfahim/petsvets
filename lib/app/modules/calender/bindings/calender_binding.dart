import 'package:get/get.dart';
import '../view_model/calender_view_model.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalenderViewModel>(
      () => CalenderViewModel(),
    );
  }
}
