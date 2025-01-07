import 'package:get/get.dart';

import '../view_model/vet_appointment_history_view_model.dart';


class VetAppointmentHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VetAppointmentHistoryViewModel>(
      () => VetAppointmentHistoryViewModel(),
    );
  }
}
