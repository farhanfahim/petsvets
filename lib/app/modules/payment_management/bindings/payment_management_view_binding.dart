import 'package:get/get.dart';
import '../view_model/payment_management_view_model.dart';

class PaymentManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentManagementViewModel>(
      () => PaymentManagementViewModel(),
    );
  }
}
