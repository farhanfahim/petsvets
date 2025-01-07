import 'package:get/get.dart';

import '../../../../../utils/argument_constants.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../routes/app_pages.dart';
class SuccessViewModel extends GetxController {

  var data = Get.arguments;


  @override
  Future<void> onInit() async {
    super.onInit();

  }

  onTap(){
    if(data[ArgumentConstants.pageType] == PageType.subscription || data[ArgumentConstants.pageType] == PageType.scheduleAppointment){
      Get.offAllNamed(Routes.DASHBOARD_VIEW);
    }else if(data[ArgumentConstants.pageType] == PageType.payment ){
      Get.offAllNamed(Routes.DASHBOARD_VIEW);
    }
    else if(data[ArgumentConstants.pageType] == PageType.otp){
      Get.offAllNamed(Routes.LOGIN);
    }
  }



}
