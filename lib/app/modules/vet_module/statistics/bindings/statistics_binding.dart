import 'package:get/get.dart';
import '../view_model/statistics_view_model.dart';


class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsViewModel>(
      () => StatisticsViewModel(),
    );
  }
}
