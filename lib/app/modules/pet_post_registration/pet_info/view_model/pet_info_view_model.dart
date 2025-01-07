import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/pet_post_registration/pet_type/view_model/pet_type_view_model.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/breed_model.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../../account_setup/view_model/account_setup_view_model.dart';

class PetInfoViewModel extends GetxController {

  final PetPostRegistrationRepository repository;

  PetInfoViewModel({required this.repository});

  final AccountSetupViewModel accountSetupViewModel = Get.find();
  final PetTypeViewModel petTypeViewModel = Get.find();
  RxList<BreedData> arrOfBreed = List<BreedData>.empty().obs;

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

      if(petTypeViewModel.arrOfSelectedPetType[pos!].breed!=null) {
        for (var item in arrOfBreed) {
          if (item.name == petTypeViewModel.arrOfSelectedPetType[pos].breed!.value) {

            petTypeViewModel.arrOfSelectedPetType[pos].breedId = item.id;
            petTypeViewModel.arrOfSelectedPetType[pos].breed = item.name!.obs;
            item.isSelected!.value = true;
          }
        }
      }

      arrOfBreed.refresh();
      isDataLoading.value = false;

    });
  }

  onTapNext(){
    RxBool isSelected = true.obs;
    for(var item in petTypeViewModel.arrOfPetType){
      if(item.isSelected!.value){
        if(item.breed!.value.isEmpty){
          isSelected.value = false;
          Util.showToast("Please Select ${item.name!} breed");
          return;
        }
      }
    }
    if(isSelected.value) {
      accountSetupViewModel.changePage(2);
    }

  }

  int getSelectedLength() {
    var count = -1;
    for(var item in petTypeViewModel.arrOfPetType){
      if(item.isSelected!.value){
        count++;
      }
    }
    return count;
  }

  onTapBack(){
    accountSetupViewModel.previousPage();
  }



}
