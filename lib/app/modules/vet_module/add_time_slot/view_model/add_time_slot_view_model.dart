import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/data/models/slot_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/dimens.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/table_calendar_view.dart';
import '../../../../data/models/calender_model.dart';
import '../../../../data/models/scheduled_model.dart';
import '../../../../data/models/select_time_model.dart';
import '../../../../repository/slot_repository.dart';
import '../../manage_time_slot/view_model/manage_time_slot_view_model.dart';

class AddTimeSlotViewModel extends GetxController {

  final SlotRepository repository;

  AddTimeSlotViewModel({required this.repository});


  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final ManageTimeSlotViewModel manageTimeSlotViewModel = Get.find();
  final ScrollController scrollController = ScrollController();
  Rx<DateTime> today = DateTimeUtil.getCurrentDate().obs;
  Rx<DateTime> currentDate = DateTimeUtil.getCurrentDate().obs;
  RxList<CalenderModel> arrOfDate = List<CalenderModel>.empty().obs;
  Rx<SlotData> selectedDuration = SlotData().obs;
  RxList<SlotData> arrOfDuration = List<SlotData>.empty().obs;
  RxList<SelectTimeModel> arrOfTimeSlot = List<SelectTimeModel>.empty().obs;
  RxList<ScheduleSlotTimes> arrOfSelectedTimeSlot = List<ScheduleSlotTimes>.empty().obs;


  RxBool isError = false.obs;
  RxString selectedAddress = ''.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;
  Rx<DateTime> selectedDateTime = DateTime.now().obs;


  @override
  void onInit() {
    super.onInit();

    getSlots();
    arrOfTimeSlot.add(SelectTimeModel(startTimeController: TextEditingController(), endTimeController: TextEditingController()));
    generateDateList(7);


  }

  generateDateList(int numberOfDays) {
    arrOfDate.clear();
    arrOfDate.refresh();
    for (int i = 0; i < numberOfDays; i++) {
      DateTime date = currentDate.value.add(Duration(days: i));

      DateFormat dateFormatter = DateFormat(DateTimeUtil.dateTimeFormat4);
      List<String> splittedDate = date.toString().split(' ');
      date = dateFormatter.parse(splittedDate.first);

      arrOfDate.add(CalenderModel(date: date, isSelected: false.obs));
    }
    arrOfDate.first.isSelected!.value = true;
    arrOfDate.refresh();
  }

  onTapCalender() {
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
            showHeader: true,
            showAction: true,
            showBottomBtn: false,
            centerTitle: false,
            titleSize: AppFontSize.small,
            actionText: "done".tr,
            actionTap: () {
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
            )));
  }

  onDateTap(index) {
    for (var item in arrOfDate) {
      item.isSelected!.value = false;
    }
    if (arrOfDate[index].isSelected!.value) {
      arrOfDate[index].isSelected!.value = false;
    } else {
      arrOfDate[index].isSelected!.value = true;
    }
    selectedDateTime.value = arrOfDate[index].date!;
  }

  onSlotTap(index) {
    if (manageTimeSlotViewModel.fullTime.isTrue) {
      for (var item in manageTimeSlotViewModel.durations) {
        item.isSelected!.value = false;
      }
      if (manageTimeSlotViewModel.durations[index].isSelected!.value) {
        manageTimeSlotViewModel.durations[index].isSelected!.value = false;
      } else {
        manageTimeSlotViewModel.durations[index].isSelected!.value = true;
      }
      manageTimeSlotViewModel.durations.refresh();
      print(manageTimeSlotViewModel.durations[index].toJson());
      selectedDuration.value = manageTimeSlotViewModel.durations[index];
    } else {
      for (var item in arrOfTimeSlot) {
        if(selectedDuration.value.duration != arrOfDuration[index].duration!){
          item.startTimeController = TextEditingController();
          item.endTimeController = TextEditingController();
        }
      }
      for (var item in arrOfDuration) {
        item.isSelected!.value = false;
      }
      if (arrOfDuration[index].isSelected!.value) {
        arrOfDuration[index].isSelected!.value = false;
        selectedDuration.value = SlotData();
      } else {
        arrOfDuration[index].isSelected!.value = true;
        selectedDuration.value = arrOfDuration[index];
      }
      selectedDuration.refresh();
      arrOfTimeSlot.refresh();
      arrOfDuration.refresh();
    }
  }

  onTapStartTime(index) {
    if (selectedDuration.value.duration != 0) {
      arrOfTimeSlot[index].startSelectedTime = DateTime.now();
      arrOfTimeSlot[index].endSelectedTime = DateTime.now().add(Duration(minutes: selectedDuration.value.duration!));
      arrOfTimeSlot.refresh();
      BottomSheetService.showGenericBottomSheet(
          child: CustomBottomSheet(
        showHeader: true,
        showClose: false,
        showAction: true,
        showLeading: false,
        showLeadingIcon: false,
        showBottomBtn: false,
        centerTitle: false,
        titleSize: AppFontSize.small,
        actionText: "done".tr,
        actionColor: AppColors.red,
        verticalPadding: AppDimen.pagesVerticalPadding,
        title: "select_time".tr,
        widget: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateTime) {
              arrOfTimeSlot[index].startSelectedTime = dateTime;
              arrOfTimeSlot[index].endSelectedTime = dateTime.add(Duration(minutes: selectedDuration.value.duration!));
              arrOfTimeSlot.refresh();
            },
          ),
        ),
        actionTap: () {
          if (arrOfTimeSlot.length > 1) {

            Rx<bool> isValidStartTime = true.obs;
            RxInt count = 0.obs;
            for (var item=0; item < arrOfTimeSlot.length; item++) {
              count.value++;
              if(item != index) {
                if (arrOfTimeSlot[item].startSelectedTime != null) {
                  if (arrOfTimeSlot[index].startSelectedTime!.isAfter(arrOfTimeSlot[item].startSelectedTime!) &&
                      arrOfTimeSlot[index].startSelectedTime!.isBefore(arrOfTimeSlot[item].endSelectedTime!)) {
                    isValidStartTime.value = false;
                  } else {
                    if (isValidStartTime.value &&
                        arrOfTimeSlot[index].endSelectedTime!.isAfter(arrOfTimeSlot[item].startSelectedTime!) &&
                        arrOfTimeSlot[index].endSelectedTime!.isBefore(arrOfTimeSlot[item].endSelectedTime!)) {
                      isValidStartTime.value = false;
                    }
                  }
                }
              }
            }

            isValidStartTime.refresh();
            if (isValidStartTime.value) {
              Get.back();
              arrOfTimeSlot[index].startTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].startSelectedTime, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
              arrOfTimeSlot[index].endTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].startSelectedTime!.add(Duration(minutes: selectedDuration.value.duration!)), outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
              arrOfTimeSlot[index].endSelectedTime = arrOfTimeSlot[index].startSelectedTime!.add(Duration(minutes: selectedDuration.value.duration!));
              arrOfTimeSlot.refresh();
            } else {
              Util.showToast("This time selection is already exist");
            }
          }else{
            Get.back();
            arrOfTimeSlot[index].startTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].startSelectedTime, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
            arrOfTimeSlot[index].endTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].startSelectedTime!.add(Duration(minutes: selectedDuration.value.duration!)), outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
            arrOfTimeSlot[index].endSelectedTime = arrOfTimeSlot[index].startSelectedTime!.add(Duration(minutes: selectedDuration.value.duration!));
            arrOfTimeSlot.refresh();
          }
        },
      ));
    } else {
      Util.showToast("Please select duration first.");
    }
  }

  onTapEndTime(index) {
    if (selectedDuration.value.duration != 0) {
      arrOfTimeSlot[index].endSelectedTime = DateTime.now();
      arrOfTimeSlot[index].startSelectedTime = DateTime.now().subtract(Duration(minutes: selectedDuration.value.duration!));
      arrOfTimeSlot.refresh();
      BottomSheetService.showGenericBottomSheet(
          child: CustomBottomSheet(
        showHeader: true,
        showClose: false,
        showAction: true,
        showLeading: false,
        showLeadingIcon: false,
        showBottomBtn: false,
        centerTitle: false,
        titleSize: AppFontSize.small,
        actionText: "done".tr,
        actionColor: AppColors.red,
        verticalPadding: AppDimen.pagesVerticalPadding,
        title: "select_time".tr,
        widget: SizedBox(
          height: 200,
          width: double.maxFinite,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateTime) {
              arrOfTimeSlot[index].endSelectedTime = dateTime;
              arrOfTimeSlot[index].startSelectedTime = dateTime.subtract(Duration(minutes: selectedDuration.value.duration!));
              arrOfTimeSlot.refresh();
            },
          ),
        ),
        actionTap: () {
          if (arrOfTimeSlot.length > 1) {
            Rx<bool> isValidStartTime = true.obs;
            RxInt count = 0.obs;
            for (var item=0; item < arrOfTimeSlot.length; item++) {
              count.value++;
              if(item != index) {
                if (arrOfTimeSlot[item].startSelectedTime != null) {
                  if (arrOfTimeSlot[index].endSelectedTime!.isAfter(arrOfTimeSlot[item].startSelectedTime!) &&
                      arrOfTimeSlot[index].endSelectedTime!.isBefore(arrOfTimeSlot[item].endSelectedTime!)) {
                    isValidStartTime.value = false;
                  } else {
                    if (isValidStartTime.value &&
                        arrOfTimeSlot[index].startSelectedTime!.isAfter(arrOfTimeSlot[item].startSelectedTime!) &&
                        arrOfTimeSlot[index].startSelectedTime!.isBefore(arrOfTimeSlot[item].endSelectedTime!)) {
                      isValidStartTime.value = false;
                    }
                  }
                }
              }
            }

            isValidStartTime.refresh();
            if (isValidStartTime.value) {
              Get.back();
              arrOfTimeSlot[index].endTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].endSelectedTime, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
              arrOfTimeSlot[index].startTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].endSelectedTime!.subtract(Duration(minutes: selectedDuration.value.duration!)), outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
              arrOfTimeSlot[index].startSelectedTime = arrOfTimeSlot[index].endSelectedTime!.subtract(Duration(minutes: selectedDuration.value.duration!));
              arrOfTimeSlot.refresh();
            } else {
              Util.showToast("This time selection is already exist");
            }
          } else {
            Get.back();
            arrOfTimeSlot[index].endTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].endSelectedTime, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
            arrOfTimeSlot[index].startTimeController!.text = DateTimeUtil.formatDateTime(arrOfTimeSlot[index].endSelectedTime!.subtract(Duration(minutes: selectedDuration.value.duration!)), outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
            arrOfTimeSlot[index].startSelectedTime = arrOfTimeSlot[index].endSelectedTime!.subtract(Duration(minutes: selectedDuration.value.duration!));
            arrOfTimeSlot.refresh();
          }
        },
      ));
    } else {
      Util.showToast("Please select duration first.");
    }
  }

  onTapSave() {
    if (manageTimeSlotViewModel.fullTime.isTrue) {
      RxBool selectedDuration = false.obs;
      for (var item in manageTimeSlotViewModel.durations) {
        if (item.isSelected!.value) {
          selectedDuration.value = true;
        }
      }
      if (selectedDuration.value) {
        addFullTimeSlot(selectedDateTime.value);
      } else {
        Util.showToast("Please select duration.");
      }
    } else {
      if (selectedDuration.value.duration != 0) {
        RxBool isSlotsEmpty = false.obs;
        for (var item in arrOfTimeSlot) {
          if (item.startTimeController!.text.isEmpty) {
            isSlotsEmpty.value = true;
          }
        }
        if (isSlotsEmpty.value) {
          Util.showToast("Please select start & end time.");
        } else {
          addSpecificSlot(selectedDateTime.value);
        }
      } else {
        Util.showToast("Please select duration.");
      }
    }
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
      arrOfDuration.value = response.data.data!;
      for(var item in arrOfDuration){
        item.isSelected = false.obs;
      }
      arrOfDuration.refresh();
      isDataLoading.value = false;

    });
  }
  Future<dynamic>  addFullTimeSlot(DateTime date) async {

    btnController.start();

    Map<String,dynamic> map = {

      "slot_id":selectedDuration.value.id,
      "type":10,
      "date":DateTimeUtil.formatDateTime(date, outputDateTimeFormat: DateTimeUtil.dateTimeFormat4),
    };

    print(map);
    final result = await repository.addFullTimeSlot(map);
    result.fold((l) {

      btnController.error();
      btnController.reset();
      isError.value = true;
      errorMessage.value = l.message;
      print(l);

    }, (response) {

      btnController.error();
      btnController.reset();

      Get.back();
      Util.showAlert(title: "your_slot_has_been_added");

    });
  }
  Future<dynamic>  addSpecificSlot(DateTime date) async {

    btnController.start();

    for(var item in arrOfTimeSlot){
      arrOfSelectedTimeSlot.add(ScheduleSlotTimes(
          startTime: DateTimeUtil.formatDate(item.startTimeController!.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
          endTime: DateTimeUtil.formatDate(item.endTimeController!.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
          ));
    }
    arrOfSelectedTimeSlot.refresh();
    Map<String,dynamic> map = {

      "slot_id":selectedDuration.value.id,
      "type":20,
      "schedule_slot_times":arrOfSelectedTimeSlot,
      "date":DateTimeUtil.formatDateTime(date, outputDateTimeFormat: DateTimeUtil.dateTimeFormat4),
    };

    print(map);
    final result = await repository.addFullTimeSlot(map);
    result.fold((l) {

      btnController.error();
      btnController.reset();
      isError.value = true;
      errorMessage.value = l.message;
      print(l);

    }, (response) {

      btnController.error();
      btnController.reset();

      Get.back();
      Util.showAlert(title: "your_slot_has_been_added");

    });
  }
}
