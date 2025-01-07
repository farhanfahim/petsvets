import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';

import '../../../../utils/Util.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/models/vet_response_model.dart';
import '../../../repository/notification_repository.dart';

class NotificationViewModel extends GetxController {


  final NotificationRepository repository;
  int currentPage = 1;
  int totalPages = 0;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  final PagingController<int, NotificationData> vetListController = PagingController<int, NotificationData>(firstPageKey: 1);

  NotificationViewModel({required this.repository});


  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    vetListController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }


  readAll(){
    for(var item in vetListController.itemList!){
      item.isSelected = false.obs;
    }
    vetListController.notifyListeners();
    onReadNotifications();
  }

  Future<dynamic> onReadNotifications() async {
    Map<String,dynamic> data = {
    };

    final result = await repository.markReadNotifications(data);
    result.fold((l) {
      print(l.message);

      Util.showAlert(title: l.message, error: true);
    }, (response) {
      print(response.message);

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
      'relations[]': "user"
    };

    final result = await repository.getNotifications(map);
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
          if(item.readAt!=null){
            item.isSelected = false.obs;
          }else{
            item.isSelected = true.obs;
          }
        }

      } else {

        currentPage = currentPage + 1;
        vetListController.appendPage(response.data.data!, currentPage);
        for(var item in vetListController.itemList!){
          if(item.readAt!=null){
            item.isSelected = false.obs;
          }else{
            item.isSelected = true.obs;
          }
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
}
