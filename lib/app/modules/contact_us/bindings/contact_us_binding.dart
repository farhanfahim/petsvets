import 'package:get/get.dart';

import '../view_model/contact_us_view_model.dart';



class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsViewModel>(
      () => ContactUsViewModel(),
    );
  }
}
