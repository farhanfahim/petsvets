import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/Attachments.dart';
import '../../../../data/models/prescription_model.dart';

class PrescribeMedicineViewModel extends GetxController {
  var formKey = GlobalKey<FormState>();
  Rx<bool> absorb = false.obs;
  RxList<PetTypeModel> arrOfFrequency = List<PetTypeModel>.empty().obs;

  RxList<PrescriptionModel> arrOfPrescription = List<PrescriptionModel>.empty().obs;

  final ScrollController scrollController=ScrollController();
  @override
  void onInit() {
    super.onInit();
    generateVets();

    arrOfFrequency.add(PetTypeModel(title: "Once every 12 hours",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "Three times daily",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "Every 6 hours",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "Every 4 hours",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "Every 2 hours",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "As needed (PRN)",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "With meals",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "Before meals",breed: "".obs,isSelected: false.obs));
    arrOfFrequency.add(PetTypeModel(title: "After meals",breed: "".obs,isSelected: false.obs));


  }

  generateVets() async {
    RxList<PetTypeModel> arrOfTimings = List<PetTypeModel>.empty().obs;
    arrOfTimings.add(PetTypeModel(title: "Morning",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "Noon",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "Evening",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "Night",breed: "".obs,isSelected: false.obs));

    arrOfPrescription.add(PrescriptionModel(
        medicineName: TextEditingController(),
        instruction: TextEditingController(),
        frequency: TextEditingController(),
        timings: TextEditingController(),
        specialInstruction: TextEditingController(),
        images: List<Attachments>.empty().obs,
        arrOfFrequency: arrOfFrequency,
        arrOfTimings: arrOfTimings,
        key: GlobalKey<FormState>()
    ));
  }

  addNew(){

    RxList<PetTypeModel> arrOfTimings = List<PetTypeModel>.empty().obs;
    arrOfTimings.add(PetTypeModel(title: "Morning",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "None",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "Evening",breed: "".obs,isSelected: false.obs));
    arrOfTimings.add(PetTypeModel(title: "Night",breed: "".obs,isSelected: false.obs));



    arrOfTimings.refresh();
    arrOfPrescription.add(PrescriptionModel(
        medicineName: TextEditingController(),
        instruction: TextEditingController(),
        frequency: TextEditingController(),
        timings: TextEditingController(),
        specialInstruction: TextEditingController(),
        images: List<Attachments>.empty().obs,
        arrOfFrequency: arrOfFrequency,
        arrOfTimings: arrOfTimings,
        key: GlobalKey<FormState>()
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  onTapPrescribe(){
    for(var item in arrOfPrescription){
      if (item.key.currentState?.validate() == true) {
        Util.showAlert(title:"the_prescription");
        Get.back();
        Get.back();
      } else {
        print('not validated');
      }
    }

  }
}
