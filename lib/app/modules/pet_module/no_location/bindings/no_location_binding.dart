import 'package:get/get.dart';

import '../view_model/no_location_view_model.dart';

class NoLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoLocationViewModel>(
      () => NoLocationViewModel(),
    );
  }
}
