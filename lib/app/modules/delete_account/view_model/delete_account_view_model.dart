import 'package:get/get.dart';
import '../../../../shared_prefrences/app_prefrences.dart';
import '../../../../utils/Util.dart';
import '../../../data/models/pet_type_model.dart';
import '../../../routes/app_pages.dart';

class DeleteAccountViewModel extends GetxController {


  RxList<PetTypeModel> arrOfOption = List<PetTypeModel>.empty().obs;
  RxBool showSubmit = false.obs;
  @override
  void onInit() {
    super.onInit();
    arrOfOption.add(PetTypeModel(title: "",breed:"privacy_concerns".tr.obs,isSelected:false.obs));
    arrOfOption.add(PetTypeModel(title: "",breed:"inactivity".tr.obs,isSelected:false.obs));
    arrOfOption.add(PetTypeModel(title: "",breed:"dissatisfaction".tr.obs,isSelected:false.obs));
    arrOfOption.add(PetTypeModel(title: "",breed:"lack_of_interest".tr.obs,isSelected:false.obs));
    arrOfOption.add(PetTypeModel(title: "",breed:"moving_on".tr.obs,isSelected:false.obs));
  }

  onSelect(index){

    for(var item in arrOfOption){
      item.isSelected!.value = false;
    }
    arrOfOption[index].isSelected!.value = true;
    for(var item in arrOfOption){
      if(item.isSelected!.value){
        showSubmit.value = true;
      }
    }
  }

  onConfirm() async {
    var currentLanguage = AppPreferences.getCurrentLanguage();

    await AppPreferences.clearPreference();

    await AppPreferences.setCurrentLanguage(language: currentLanguage);

    Get.offAllNamed(Routes.LOGIN);
    Util.showAlert(title: "account_has_been_deleted");
  }


}
