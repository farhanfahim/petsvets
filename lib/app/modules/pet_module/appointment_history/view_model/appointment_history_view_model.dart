import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../repository/pet_appointment_repository.dart';

class AppointmentHistoryViewModel extends GetxController {

  final PetAppointmentRepository repository;
  int currentPage = 1;
  int totalPages = 0;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  final PagingController<int, AppointmentData> vetListController = PagingController<int, AppointmentData>(firstPageKey: 1);

  AppointmentHistoryViewModel({required this.repository});


  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    vetListController.addPageRequestListener((pageKey) {
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

  Future<dynamic>  getVets({bool isRefresh = false,int type = 0}) async {

    isDataLoading.value = isRefresh ? false : true;

    var map = {
      'page': currentPage,
      'relations':['user','vet'],
      if(type != 0)'status[]': type,/// 'status[]': 40, for completed appointments
    };

    final result = await repository.getAppointments(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;
      print(l.message);

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

        for(var item in response.data.data!){
          item.status = 40;
          item.type = StatusType.completed;

        }

      } else {

        currentPage = currentPage + 1;

        vetListController.appendPage(response.data.data!, currentPage);
        for(var item in response.data.data!){
          if(item.status == 10){
            item.type = StatusType.pending;
          }
          if(item.status == 20){
            item.type = StatusType.cancelled;
          }
          if(item.status == 30){
            item.type = StatusType.confirmed;
          }
          if(item.status == 40){
            item.type = StatusType.completed;
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
