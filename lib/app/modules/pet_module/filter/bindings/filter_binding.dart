import 'package:get/get.dart';
import '../view_model/filter_view_model.dart';


class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterViewModel>(
      () => FilterViewModel(),
    );
  }
}
