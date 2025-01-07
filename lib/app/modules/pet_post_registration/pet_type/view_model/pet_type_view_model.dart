import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../../account_setup/view_model/account_setup_view_model.dart';

class PetTypeViewModel extends GetxController {

  final PetPostRegistrationRepository repository;

  PetTypeViewModel({required this.repository});

  var formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController(text: "");
  final AccountSetupViewModel accountSetupViewModel = Get.find();
  FocusNode petNameNode = FocusNode();
  RxList<PetData> arrOfPetType = List<PetData>.empty().obs;
  RxList<PetData> arrOfSelectedPetType = List<PetData>.empty().obs;
  Rx<bool> isTypeSelect = false.obs;



  int currentPage = 1;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
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
      print(response);
      if(isRefresh) {
        arrOfPetType.clear();
      }

      for(var item in response.data.data!){
        item.isSelected = false.obs;
      }
      arrOfPetType.value = response.data.data!;
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
           PetData(name: petNameController.text, isSelected: true.obs)
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
    for(var item in arrOfSelectedPetType){
      print(item.toJson());
    }
    if(isTypeSelect.value) {
      arrOfPetType.refresh();
      accountSetupViewModel.changePage(1);
    }else{
      Util.showToast("select_pet".tr);
    }
  }

}
