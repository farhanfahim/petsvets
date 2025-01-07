import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/pet_response_model.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../repository/pet_profile_repository.dart';

class ProfileViewModel extends GetxController {
  Rx<bool> isTypeSelect = false.obs;
  Rx<UserModel> userModel = UserModel().obs;

  final PetProfileRepository repository;

  ProfileViewModel({required this.repository});
  RxList<Data> arrOfPetType = List<Data>.empty().obs;

  int currentPage = 1;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;


  @override
  void onInit() {
    super.onInit();


    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      print(userModel.value.user!.toJson());
    });
    getBPets();
  }


  Future<dynamic>  getBPets({bool isRefresh = false,int? pos}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'limit':1000
    };

    final result = await repository.getPets(map);
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
        print(item.toJson());
      }

      arrOfPetType.value = response.data.data!;
      arrOfPetType.refresh();
      isDataLoading.value = false;

    });
  }


  Future<dynamic> deletePetAPI(int id,int pos) async {

    Map<String,dynamic> data = {
      "id": id,
    };

    final result = await repository.deletePets(data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
    });
  }

  int getSelectedLength() {
    var count = -1;
    for(var item in arrOfPetType){
      if(item.isSelected!.value){
        count++;
      }
    }
    return count;
  }
}
