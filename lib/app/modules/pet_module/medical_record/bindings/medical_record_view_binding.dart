import 'package:get/get.dart';

import '../view_model/medical_record_view_model.dart';

class MedicalRecordViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalRecordViewModel>(
      () => MedicalRecordViewModel(),
    );
  }
}
