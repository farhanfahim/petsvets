import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';

import '../../../../../utils/Util.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../data/models/pet_response_model.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../repository/add_pet_repository.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../../profile/view_model/profile_view_model.dart';

class AddPetViewModel extends GetxController {

  final AddPetRepository repository;

  AddPetViewModel({required this.repository});

  var formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController(text: "");
  FocusNode petNameNode = FocusNode();
  Rx<bool> isTypeSelect = false.obs;

  RxList<Data> oldOfPetType = List<Data>.empty().obs;
  RxList<PetData> arrOfPetType = List<PetData>.empty().obs;
  RxList<PetData> arrOfSelectedPetType = List<PetData>.empty().obs;


  var data = Get.arguments;
  int currentPage = 1;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if(data !=null){
      oldOfPetType = data[ArgumentConstants.list];
    }
    getPet();
  }


  Future<dynamic>  getPet({bool isRefresh = false}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'limit':1000
    };

    final result = await repository.getPet(map);
    result.fold((l) {

      print(l.message);
      isDataLoading.value = false;
      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {
      print(response.data.toJson());
      if(isRefresh) {
        arrOfPetType.clear();
      }
      for(var item in response.data.data!){
        item.isSelected = false.obs;
        item.breedId = -1;
        item.breed = "".obs;
        if(oldOfPetType.isNotEmpty) {
          bool exists = oldOfPetType.any((pet) => pet.name == item.name);
          if (!exists) {

            arrOfPetType.add(item);
          }
        }else{

          arrOfPetType.add(item);
        }


      }

      for(var item2 in oldOfPetType){
        print(item2.toJson());
        arrOfPetType.add(PetData(
            id: item2.id,
            name: item2.name,
            breedId: item2.breedId,
            breed: item2.breed!.obs,
            isSelected: true.obs));
      }



      arrOfPetType.refresh();
      arrOfPetType.add(PetData(id: -1,name: "Other", isSelected: false.obs));
      isDataLoading.value = false;

    });
  }

  void refreshData() {
    isError.value = false;
    errorMessage.value = '';
    currentPage = 1;

    getPet(isRefresh: true);
  }

  void onDoneTap() {


    if (formKey.currentState?.validate() == true) {
      arrOfPetType.insert(
          arrOfPetType.length-1,
          PetData(name: petNameController.text, isSelected: true.obs,breed: "".obs)
      );
      petNameController.text  = "";

      Get.back();
    } else {
      print('not validated');
    }
  }


  onTapNext(){

    arrOfSelectedPetType.clear();
    for(var item in arrOfPetType){
      if(item.isSelected!.value){
        isTypeSelect.value = true;
        arrOfSelectedPetType.add(item);
      }
    }
    if(isTypeSelect.value) {
      arrOfPetType.refresh();
      Get.toNamed(Routes.PET_MORE_INFO)!.then((value) {
        Get.back(result: arrOfSelectedPetType);
      });
    }else{
      Util.showToast("select_pet".tr);
    }
  }

}
