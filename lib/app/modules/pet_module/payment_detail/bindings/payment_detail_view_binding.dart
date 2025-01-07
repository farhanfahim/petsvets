import 'package:get/get.dart';
import '../view_model/payment_detail_view_model.dart';

class PaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailViewModel>(
      () => PaymentDetailViewModel(),
    );
  }
}
