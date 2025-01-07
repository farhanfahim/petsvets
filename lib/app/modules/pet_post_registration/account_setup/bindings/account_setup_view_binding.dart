import 'package:get/get.dart';
import '../view_model/account_setup_view_model.dart';

class AccountSetupViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSetupViewModel>(
      () => AccountSetupViewModel(),
    );
  }
}
