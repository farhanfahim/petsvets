import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';

class FilterViewModel extends GetxController {
  RxList<PetTypeModel> arrOfFilter = List<PetTypeModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    generateVets();
  }

  generateVets() async {
    arrOfFilter.add(PetTypeModel(title: "confirmed".tr,breed: "".obs,isSelected: false.obs,));
    arrOfFilter.add(PetTypeModel(title: "pending".tr,breed: "".obs,isSelected: false.obs,));
    arrOfFilter.add(PetTypeModel(title: "cancelled".tr,breed: "".obs,isSelected: false.obs,));

  }
}
