import 'package:get/get.dart';
import '../../../../shared_prefrences/app_prefrences.dart';
import '../../../components/resources/app_images.dart';
import '../../../data/models/pet_type_model.dart';
import '../../../data/models/setting_model.dart';

class PaymentManagementViewModel extends GetxController {


  RxList<SettingModel> arrOfSetting = List<SettingModel>.empty().obs;
  RxList<PetTypeModel> arrOfPayment = List<PetTypeModel>.empty().obs;

  var payoutModel = PetTypeModel(title: "",breed:"Paypal".obs,isSelected:false.obs);

  RxString role = "".obs;

  @override
  void onInit() {
    super.onInit();
    role.value = AppPreferences.getRole();

    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Apple Pay".obs,isSelected:true.obs));
    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Paypal".obs,isSelected:true.obs));
    arrOfPayment.add(PetTypeModel(title: "******* 1234",breed:"Mastercard".obs,isSelected:true.obs));
    arrOfSetting.add(SettingModel(title: "add_new_card".tr,image: AppImages.card2,isSelected: false.obs,));



  }


}
