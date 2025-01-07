import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/auth/splash/view_model/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(),
    );
  }
}
