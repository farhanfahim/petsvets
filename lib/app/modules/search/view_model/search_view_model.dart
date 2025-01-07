import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/dummy_appointment_model.dart';
import '../../../data/models/vet_response_model.dart';
import '../../../repository/search_repository.dart';

class SearchViewModel extends GetxController {
  final SearchRepository repository;
  SearchViewModel({required this.repository});
  RxList<DummyAppointmentModel> recentSearches = List<DummyAppointmentModel>.empty().obs;
  RxBool showRecentSearches = false.obs;
  RxBool showResults = false.obs;
  RxBool noResults = true.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();
  Timer? debounce;
  RxInt? selectedIndex;
  int currentPage = 1;
  int totalPages = 0;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  final PagingController<int, VetData> vetListController = PagingController<int, VetData>(firstPageKey: 1);


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
      //getVets();
    } catch (error) {
      vetListController.error = error;
    }
  }

  Future<dynamic>  getVets({bool isRefresh = false}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'search': searchController.value.text,
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
      if(vetListController.itemList!.isNotEmpty){
        noResults.value = false;
      }

      isDataLoading.value = false;

    });
  }


  void refreshData() {
    isError.value = false;
    errorMessage.value = '';
    currentPage = 1;

    getVets(isRefresh: true);
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }
}
