import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/Attachments.dart';
import '../../../../data/models/add_more_pet_model.dart';
import '../../../../data/models/add_pet_model.dart';
import '../../../../data/models/breed_model.dart';
import '../../../../repository/add_pet_repository.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../../add_pet/view_model/add_pet_view_model.dart';
import '../../profile/view_model/profile_view_model.dart';

class PetMoreInfoViewModel extends GetxController {

  final AddPetRepository repository;

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  PetMoreInfoViewModel({required this.repository});

  RxList<BreedData> arrOfBreed = List<BreedData>.empty().obs;
  final AddPetViewModel addPetViewModel = Get.find();

  RxList<Attachments> arrOfImage = List<Attachments>.empty().obs;
  Rx<AddMorePetModel> model = AddMorePetModel().obs;

  int currentPage = 1;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }




  Future<dynamic>  getBreed({bool isRefresh = false,int? pos}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'limit':1000
    };

    final result = await repository.getBreed(map);
    result.fold((l) {

      print(l.message);
      isDataLoading.value = false;
      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {
      print(response);
      if(isRefresh) {
        arrOfBreed.clear();
      }

      for(var item in response.data.data!){
        item.isSelected = false.obs;
      }

      arrOfBreed.value = response.data.data!;

      if(addPetViewModel.arrOfSelectedPetType[pos!].breed!=null) {
        for (var item in arrOfBreed) {
          if (item.name == addPetViewModel.arrOfSelectedPetType[pos].breed!.value) {

            addPetViewModel.arrOfSelectedPetType[pos].breedId = item.id;
            addPetViewModel.arrOfSelectedPetType[pos].breed = item.name!.obs;
            item.isSelected!.value = true;
          }
        }
      }

      arrOfBreed.refresh();
      isDataLoading.value = false;

    });
  }


  int getSelectedLength() {
    var count = -1;
    for(var item in addPetViewModel.arrOfSelectedPetType){
      if(item.isSelected!.value){
        count++;
      }
    }
    return count;
  }



  onTapSave(){
    RxBool isSelected = true.obs;
    for(var item in addPetViewModel.arrOfSelectedPetType){
      print(item.toJson());
      if(item.isSelected!.value){
        if(item.breed!.isEmpty){
          isSelected.value = false;
          Util.showToast("Please Select ${item.name!} breed");
          return;
        }
      }
    }
    if(isSelected.value) {
      model.value.userPets = [];
      for(var item in addPetViewModel.arrOfSelectedPetType){
        if(item.breedId!=null) {
          model.value.userPets!.add(UserPets(
              name: item.name!, breed: item.breed!.value, breedId: item.breedId));
        }else{

          model.value.userPets!.add(UserPets(
            name: item.name!, breed: item.breed!.value,));
        }

      }
      log(jsonEncode(model.value.toJson()));
      addRecordAPI();
    }

  }


  Future<dynamic> addRecordAPI() async {
    btnController.start();

    final result = await repository.addPet(model.value.toJson());
    result.fold((l) {
      print(l.message);

      Util.showAlert(title: l.message,error: true);

      btnController.error();
      btnController.reset();

    }, (response) {
      btnController.success();
      btnController.reset();
      Get.back();
    });


  }



}
