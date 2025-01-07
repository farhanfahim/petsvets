import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/models/vet_detail_model.dart';
import '../../../../repository/pet_home_repository.dart';

class VetProfileViewModel extends GetxController {


  final PetHomeRepository repository;

  VetProfileViewModel({required this.repository});


  var data = Get.arguments;
  RxBool isError = false.obs;
  RxString selectedAddress = ''.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  Rx<VetDetailResponseModel> model = VetDetailResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    getVetDetails();


  }

  Future<dynamic>  getVetDetails() async {

    isDataLoading.value =  true;

    Map<String,dynamic> map = {

      'relations':['user_detail','user_image'],
    };

    final result = await repository.getVetDetail(data['id'],map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {

      model.value = response.data;
      model.refresh();
      getAddressFromLatLng(Get.context,model.value.latitude!,model.value.longitude!).then((value) {
        selectedAddress.value = value;
      });
      isDataLoading.value = false;

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
