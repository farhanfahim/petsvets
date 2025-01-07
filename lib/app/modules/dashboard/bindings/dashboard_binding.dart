import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/dashboard/view_model/dashboard_view_model.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardViewModel>(
      () => DashboardViewModel(),
    );
  }
}
