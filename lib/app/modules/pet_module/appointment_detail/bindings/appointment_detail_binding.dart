import 'package:get/get.dart';
import '../view_model/appointment_detail_model.dart';


class AppointmentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentDetailViewModel>(
      () => AppointmentDetailViewModel(),
    );
  }
}
