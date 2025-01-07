import 'package:get/get.dart';

import '../view_model/vet_account_setup_view_model.dart';

class VetAccountSetupViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VetAccountSetupViewModel>(
      () => VetAccountSetupViewModel(),
    );
  }
}
