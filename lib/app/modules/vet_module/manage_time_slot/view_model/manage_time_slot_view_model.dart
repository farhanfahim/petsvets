import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/data/models/slot_model.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/dimens.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/table_calendar_view.dart';
import '../../../../data/models/calender_model.dart';
import '../../../../data/models/duration_model.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/select_time_model.dart';
import '../../../../repository/slot_repository.dart';
import '../../../../routes/app_pages.dart';

class ManageTimeSlotViewModel extends GetxController {

  final SlotRepository repository;

  ManageTimeSlotViewModel({required this.repository});

  Rx<bool> fullTime = true.obs;
  Rx<bool> specificTime = false.obs;
  Rx<DateTime> today = DateTimeUtil.getCurrentDate().obs;
  Rx<DateTime> currentDate = DateTimeUtil.getCurrentDate().obs;
  RxList<CalenderModel> arrOfDate = List<CalenderModel>.empty().obs;
  RxList<SlotData> durations = List<SlotData>.empty().obs;
  RxList<DurationModel> arrOfTimeSlot = List<DurationModel>.empty().obs;
  Rx<SlotData> selectedDuration = SlotData().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool isDurationsEmpty = true.obs;
  RxList<String> arrOfOption = List<String>.empty().obs;


  RxBool isError = false.obs;
  RxString selectedAddress = ''.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    generateDateList(7);
    getSlots();
    getScheduledSlots(DateTime.now());
    arrOfOption.add("edit".tr);
    arrOfOption.add("remove".tr);
  }

  generateDateList(int numberOfDays) {
    arrOfDate.clear();
    arrOfDate.refresh();
    for (int i = 0; i < numberOfDays; i++) {
      DateTime date = currentDate.value.add(Duration(days: i));

      DateFormat dateFormatter = DateFormat(DateTimeUtil.dateTimeFormat4);
      List<String> splittedDate = date.toString().split(' ');
      date = dateFormatter.parse(splittedDate.first);


      arrOfDate.add(CalenderModel(date: date,isSelected: false.obs));
    }
    arrOfDate.first.isSelected!.value = true;
    arrOfDate.refresh();
  }

  onTapCalender(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
            showHeader: true,
            showAction: true,
            showBottomBtn: false,
            centerTitle: false,
            titleSize: AppFontSize.small,
            actionText: "done".tr,
            actionTap: (){
              generateDateList(7);
              Get.back();

            },
            actionColor: AppColors.red,
            verticalPadding: AppDimen.pagesVerticalPadding,
            title: "select_date".tr,
            widget: Container(
              height: 90.w,
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: TableCalendarView(
                  isShowTime: false,
                  isUseExpanded: true,
                  selectedDate: currentDate.value,
                  pastDateEnabled: false,
                  onSelectDate: (date) {
                    currentDate.value = date;
                  }),
            )
        ));
  }

  onDateTap(index){
    for(var item in arrOfDate){
      item.isSelected!.value = false;
    }
    if(arrOfDate[index].isSelected!.value){
      arrOfDate[index].isSelected!.value = false;
    }else{
      arrOfDate[index].isSelected!.value = true;
      getScheduledSlots(arrOfDate[index].date!);
      selectedDate.value = arrOfDate[index].date!;
    }
  }

  onTapSlot(index, subIndex){
    RxInt durationInInt = 0.obs;
    if(arrOfTimeSlot[index].duration == "15_minutes".tr){
      selectedDuration.value.isSelected = true.obs;
      durationInInt.value = 15;
    }else if(arrOfTimeSlot[index].duration == "20_minutes".tr){
      selectedDuration.value.isSelected = true.obs;
      durationInInt.value = 20;
    }else if(arrOfTimeSlot[index].duration == "30_minutes".tr){
      selectedDuration.value.isSelected = true.obs;
      durationInInt.value = 30;
    }else {
      selectedDuration.value.isSelected = true.obs;
      durationInInt.value = 45;
    }

    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "select_action".tr,
          widget: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
            itemCount: arrOfOption.length,
            itemBuilder: (BuildContext context, int pos) {
              return GestureDetector(
                onTap: (){
                  Get.back();
                  if(arrOfOption[pos] == "remove".tr){
                    BottomSheetService.showConfirmationDialog(
                      title: "remove_slot",
                      content: "remove_slot_desc",
                      leftButtonText: "cancel",
                      rightButtonText: "remove",
                      onAgree: () async {
                        Get.back();
                        arrOfTimeSlot[index].timeSlots!.removeAt(subIndex);
                        arrOfTimeSlot.refresh();
                        Util.showAlert(title: "your_slot_has_been_remove");
                      },
                    );
                  }else{

                    Get.toNamed(Routes.EDIT_SLOT,arguments: {
                      ArgumentConstants.position :index,
                      ArgumentConstants.subPosition :subIndex,
                      ArgumentConstants.duration:durationInInt.value,
                      ArgumentConstants.startTime:arrOfTimeSlot[index].timeSlots![subIndex].startTime,
                      ArgumentConstants.endTime:arrOfTimeSlot[index].timeSlots![subIndex].endTime,
                    })!.then((value) {

                      getScheduledSlots(selectedDate.value);
                    });

                  }

                },
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                  child: MyText(
                    text: arrOfOption[pos],
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  onTapDuration(index){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "select_action".tr,
          widget: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
            itemCount: arrOfOption.length,
            itemBuilder: (BuildContext context, int subIndex) {
              return GestureDetector(
                onTap: (){
                  Get.back();
                  if(arrOfOption[subIndex] == "remove".tr){
                    BottomSheetService.showConfirmationDialog(
                      title: "remove_slot",
                      content: "remove_slot_desc",
                      leftButtonText: "cancel",
                      rightButtonText: "remove",
                      onAgree: () async {
                        Get.back();

                        durations[index].isSelected!.value = false;
                        durations.refresh();

                        for(var item in durations){
                          if(item.isSelected!.value){
                            isDurationsEmpty.value = false;
                          }else{
                            isDurationsEmpty.value = true;
                          }
                        }
                        Util.showAlert(title: "your_slot_has_been_remove");
                      },
                    );
                  }else{
                    Get.toNamed(Routes.EDIT_SLOT);
                  }

                },
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                  child: MyText(
                    text: arrOfOption[subIndex],
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  onTapAddSlot(){
    Get.toNamed(Routes.ADD_TIME_SLOT)!.then((value) {
      getScheduledSlots(selectedDate.value);

    });
  }



  Future<dynamic>  getSlots() async {

    isDataLoading.value =  true;

    Map<String,dynamic> map = {

    };

    final result = await repository.getAdminSlots(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;
      print(l);

    }, (response) {
      print(response.data.toJson());
      durations.value = response.data.data!;
      for(var item in durations){
        item.isSelected = false.obs;
      }
      durations.refresh();
      isDataLoading.value = false;

    });
  }

  Future<dynamic>  getScheduledSlots(DateTime date) async {

    isDataLoading.value =  true;

    arrOfTimeSlot.clear();

    isDurationsEmpty.value = true;
    for(var item in durations){
      item.isSelected!.value = false;
    }
    Map<String,dynamic> map = {
      'date':DateTimeUtil.formatDateTime(date,outputDateTimeFormat: DateTimeUtil.dateTimeFormat4),
      'relations[]':"schedule_slots",
    };

    final result = await repository.getScheduledSlots(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;
      print(l);

    }, (response) {
      print(response.data.toJson());

      for(var item1 in response.data.scheduleSlots!){
        if(item1.scheduleSlotTimes!.isEmpty) {
          for (var item2 in durations) {
            if (item1.slot!.duration == item2.duration!) {
              item2.isSelected!.value = true;
              isDurationsEmpty.value = false;
            }
          }
        }else{

            TimeOfDay _startTime;
            TimeOfDay _endTime;
            List<TimeSlotModel> listOfTimeSlot = [];

            for(var item in item1.scheduleSlotTimes!){
              _startTime = TimeOfDay(hour:int.parse(item.startTime!.split(":")[0]),minute: int.parse(item.startTime!.split(":")[1]));
              _endTime = TimeOfDay(hour:int.parse(item.endTime!.split(":")[0]),minute: int.parse(item.endTime!.split(":")[1]));

              listOfTimeSlot.add(TimeSlotModel(startTime: _startTime,
                  endTime: _endTime,
                  isSelected: false.obs));
            }
            if(item1.slot!.duration == 15){

              arrOfTimeSlot.add(DurationModel(duration: "15_minutes".tr, timeSlots: listOfTimeSlot));

            }else if(item1.slot!.duration == 20){

              arrOfTimeSlot.add(DurationModel(duration: "20_minutes".tr, timeSlots: listOfTimeSlot));

            }else if(item1.slot!.duration == 30){

              arrOfTimeSlot.add(DurationModel(duration: "30_minutes".tr, timeSlots: listOfTimeSlot));

            }else if(item1.slot!.duration == 45){

              arrOfTimeSlot.add(DurationModel(duration: "45_minutes".tr, timeSlots: listOfTimeSlot));

            }

        }
      }
      durations.refresh();
      isDataLoading.value = false;

    });
  }

}
