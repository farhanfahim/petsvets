import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/local_location.dart';
import 'package:petsvet_connect/utils/Util.dart';
import '../../../../../../utils/argument_constants.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../data/models/location.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/setting_model.dart';
import '../../../../routes/app_pages.dart';

class PaymentDetailViewModel extends GetxController {


  RxList<SettingModel> arrOfSetting = List<SettingModel>.empty().obs;

  RxList<PetTypeModel> arrOfPayment = List<PetTypeModel>.empty().obs;
  Rx<LocalLocation>? loc = LocalLocation().obs;
  RxBool showLocation = false.obs;
  RxBool showAddress = false.obs;

  var data = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Apple Pay".obs,isSelected:false.obs));
    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Paypal".obs,isSelected:false.obs));
    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Mastercard".obs,isSelected:false.obs));
    arrOfSetting.add(SettingModel(title: "add_new_card".tr,image: AppImages.card2,isSelected: false.obs,));

    if(data[ArgumentConstants.pageType] == PageType.scheduleAppointment){
      showAddress.value = true;
    }else if(data[ArgumentConstants.pageType] == PageType.cancellation ||  data[ArgumentConstants.pageType] == PageType.subscription ){
      showAddress.value = false;
    }

  }


  onPayNow(){
    RxBool isSelected = false.obs;
    for (var item in arrOfPayment) {
      if (item.isSelected!.value) {
        isSelected.value = true;
      }
    }
    isSelected.refresh();
    showLocation.refresh();
    if(data[ArgumentConstants.pageType] == PageType.cancellation){
      if (isSelected.value) {
        Get.back();
        Get.back();
        Get.back();
        Util.showAlert(title: "your_appointment_has_benn_cancelled");
      } else {
        Util.showToast("Please select payment");
      }
    }else if(data[ArgumentConstants.pageType] == PageType.subscription){
      if (isSelected.value) {
        Get.offAllNamed(Routes.SUCCESS,arguments: {
          ArgumentConstants.pageType:PageType.subscription,
          ArgumentConstants.message:"subscription_success".tr
        });
      } else {
        Util.showToast("Please select payment");
      }
    }else{
      if (showLocation.value) {
        if (isSelected.value) {
          Get.offAllNamed(Routes.SUCCESS,arguments: {
            ArgumentConstants.pageType:PageType.scheduleAppointment,
            ArgumentConstants.message:"your_request_has_been_forward".tr
          });

        } else {
          Util.showToast("Please select payment");
        }
      } else {
        Util.showToast("Please select shipping address");
      }
    }

  }



}
