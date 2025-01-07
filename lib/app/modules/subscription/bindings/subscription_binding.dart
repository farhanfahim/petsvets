import 'package:get/get.dart';

import '../view_model/subscription_view_model.dart';

class SubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionViewModel>(
      () => SubscriptionViewModel(),
    );
  }
}
