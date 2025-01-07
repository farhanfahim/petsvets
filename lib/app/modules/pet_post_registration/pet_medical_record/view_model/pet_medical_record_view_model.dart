import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/Attachments.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/add_pet_model.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../account_setup/view_model/account_setup_view_model.dart';
import '../../pet_type/view_model/pet_type_view_model.dart';

class PetMedicalRecordViewModel extends GetxController {

  final PetPostRegistrationRepository repository;

  PetMedicalRecordViewModel({required this.repository});


  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  var formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController(text: "");
  final AccountSetupViewModel accountSetupViewModel = Get.find();
  final PetTypeViewModel petTypeViewModel = Get.find();
  FocusNode petNameNode = FocusNode();
  Rx<bool> isTypeSelect = false.obs;
  RxList<Attachments> arrOfImage = List<Attachments>.empty().obs;
  Rx<AddPetModel> model = AddPetModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  onTapNext(){
    model.value.userPets = [];
    model.value.medicalRecords = [];
    for(var item in petTypeViewModel.arrOfSelectedPetType){
      if(item.breedId!=null) {
        model.value.userPets!.add(UserPets(
            name: item.name!, breed: item.breed!.value, breedId: item.breedId));
      }else{

        model.value.userPets!.add(UserPets(
            name: item.name!, breed: item.breed!.value,));
      }

    }
    for(var item in arrOfImage){
      model.value.medicalRecords!.add(MedicalRecords(type: item.imageType.name.toString(),path: item.url!));
    }

    log(jsonEncode(model.value.toJson()));
    addRecordAPI();
  }

  onTapBack(){
    accountSetupViewModel.previousPage();
  }


  Future<dynamic> addRecordAPI() async {
    btnController.start();

    final result = await repository.addPetRecord(model.value.toJson());
    result.fold((l) {
      print(l.message);

      Util.showAlert(title: l.message,error: true);

      btnController.error();
      btnController.reset();

    }, (response) {
      btnController.success();
      btnController.reset();
      Get.toNamed(Routes.SUBSCRIPTION);
    });


  }

}
