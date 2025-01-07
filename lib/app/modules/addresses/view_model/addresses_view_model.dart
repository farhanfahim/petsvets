import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/address_response_model.dart';
import '../../../../utils/Util.dart';
import '../../../repository/address_repository.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddressesViewModel extends GetxController {


  final AddressRepository repository;

  AddressesViewModel({required this.repository});

  int currentPage = 1;
  int totalPages = 0;

  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  RxBool isDataLoading = false.obs;

  final PagingController<int, AddressData> arrOfAddress = PagingController<int, AddressData>(firstPageKey: 1);


  RxList<String> arrOfOption = List<String>.empty().obs;



  @override
  void onInit() {

    super.onInit();
    arrOfOption.add("set_as_default".tr);
    arrOfOption.add("delete_address".tr);
    arrOfAddress.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      getAddress();
    } catch (error) {
      arrOfAddress.error = error;
    }
  }

  Future<dynamic>  getAddress({bool isRefresh = false}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
    };

    final result = await repository.getAddress(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {

      if(isRefresh) {
        if(arrOfAddress.itemList != null) {
          arrOfAddress.itemList!.clear();
        }
      }
      totalPages = response.data.meta!.lastPage!;

      final isNotLastPage = currentPage + 1 <= totalPages;

      if (!isNotLastPage) {

        arrOfAddress.appendLastPage(response.data.data!);
        for(var item in arrOfAddress.itemList!){
          if(item.isDefault == 1){
            item.isSelected = true.obs;
          }else{
            item.isSelected = false.obs;
          }
        }

      } else {

        currentPage = currentPage + 1;

        arrOfAddress.appendPage(response.data.data!, currentPage);
        for(var item in arrOfAddress.itemList!){
          if(item.isDefault == 1){
            item.isSelected = true.obs;
          }else{
            item.isSelected = false.obs;
          }
        }
      }

      isDataLoading.value = false;

    });
  }


  void refreshData() {
    isError.value = false;
    errorMessage.value = '';
    currentPage = 1;

    getAddress(isRefresh: true);
  }


  Future<dynamic> deleteAddressAPI(int id) async {

    Map<String,dynamic> data = {
      "id": id,
    };

    final result = await repository.deleteAddress(data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
    });
  }
  Future<dynamic> updateAddressAPI(int id,bool isDefault) async {

    Map<String,dynamic> data = {
      "is_default": isDefault?true:false,
    };

    final result = await repository.updateAddress(id,data);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
    });
  }



}
