import 'package:get/get.dart';
import '../view_model/my_bookings_view_model.dart';


class MyBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBookingsViewModel>(
      () => MyBookingsViewModel(),
    );
  }
}
