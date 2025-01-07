import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../repository/vet_profile_repository.dart';

class VetMyProfileViewModel extends GetxController {
  Rx<bool> isTypeSelect = false.obs;

  Rx<UserModel> userModel = UserModel().obs;

  final VetProfileRepository repository;

  VetMyProfileViewModel({required this.repository});

  int currentPage = 1;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxString address = ''.obs;
  RxBool isDataLoading = false.obs;


  @override
  void onInit() {
    super.onInit();

    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      getAddressFromLatLng(Get.context,userModel.value.user!.latitude!,userModel.value.user!.longitude!,).then((value) {
        address.value = value;
      });
    });
  }



  Future<String> getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${Constants.mapApiKey}&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return "";
    } else return "";
  }

}
