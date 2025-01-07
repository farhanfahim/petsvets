import 'package:get/get.dart';
import '../view_model/prescirbe_medicine_view_model.dart';


class PrescribeMedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrescribeMedicineViewModel>(
      () => PrescribeMedicineViewModel(),
    );
  }
}
