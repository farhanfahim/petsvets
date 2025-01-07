import 'package:get/get.dart';
import '../view_model/vet_appointment_detail_model.dart';


class VetAppointmentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VetAppointmentDetailViewModel>(
      () => VetAppointmentDetailViewModel(),
    );
  }
}
