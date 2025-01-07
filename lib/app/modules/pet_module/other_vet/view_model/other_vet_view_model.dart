import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/models/vet_response_model.dart';
import '../../../../repository/pet_home_repository.dart';

class OtherVetViewModel extends GetxController {

  final PetHomeRepository repository;
  int currentPage = 1;
  int totalPages = 0;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  final PagingController<int, VetData> vetListController = PagingController<int, VetData>(firstPageKey: 1);

  OtherVetViewModel({required this.repository});

  @override
  void onInit() {
    super.onInit();
    vetListController.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      getVets();
    } catch (error) {
      vetListController.error = error;
    }
  }

  Future<dynamic>  getVets({bool isRefresh = false}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'relations':['user_detail','user_image'],
    };

    final result = await repository.getVets(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {

      if(isRefresh) {

        if(vetListController.itemList != null) {
          vetListController.itemList!.clear();
        }
      }
      totalPages = response.data.meta!.lastPage!;

      final isNotLastPage = currentPage + 1 <= totalPages;

      if (!isNotLastPage) {

        vetListController.appendLastPage(response.data.data!);
        for(var item in vetListController.itemList!){
          item.isSelected = false.obs;
          item.address = "".obs;
        }

      } else {

        currentPage = currentPage + 1;

        vetListController.appendPage(response.data.data!, currentPage);
        for(var item in vetListController.itemList!){
          item.isSelected = false.obs;
          item.address = "".obs;
        }
      }



    });
  }


  void refreshData() {
    isError.value = false;
    errorMessage.value = '';
    currentPage = 1;


    getVets(isRefresh: true);
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
