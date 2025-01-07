import 'package:get/get.dart';
import '../view_model/statistics_detail_model.dart';

class StatisticsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsDetailViewModel>(
      () => StatisticsDetailViewModel(),
    );
  }
}
