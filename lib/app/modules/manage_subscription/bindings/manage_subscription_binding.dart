import 'package:get/get.dart';
import '../view_model/manage_subscription_view_model.dart';

class ManageSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageSubscriptionViewModel>(
      () => ManageSubscriptionViewModel(),
    );
  }
}
