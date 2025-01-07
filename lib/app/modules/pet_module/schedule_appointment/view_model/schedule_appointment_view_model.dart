import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/data/enums/page_type.dart';
import 'package:petsvet_connect/app/data/models/scheduled_model.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/app_font_size.dart';
import '../../../../../../utils/bottom_sheet_service.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/pet_single_selection_widget.dart';
import '../../../../components/widgets/table_calendar_view.dart';
import '../../../../data/models/Attachments.dart';
import '../../../../data/models/calender_model.dart';
import '../../../../data/models/duration_model.dart';
import '../../../../data/models/pet_response_model.dart';
import '../../../../data/models/slot_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../repository/schedule_repository.dart';

class ScheduleAppointmentViewModel extends GetxController {

  final ScheduleRepository repository;
  ScheduleAppointmentViewModel({required this.repository});

  Rx<UserModel> userModel = UserModel().obs;
  var formKey = GlobalKey<FormState>();
  Rx<TextEditingController> petController = TextEditingController().obs;
  FocusNode petNode = FocusNode();
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  FocusNode reasonNode = FocusNode();

  final ScrollController scrollController=ScrollController();
  final controller = ValueNotifier<bool>(false);
  Rx<DateTime> today = DateTimeUtil.getCurrentDate().obs;
  Rx<DateTime> currentDate = DateTimeUtil.getCurrentDate().obs;
  RxList<CalenderModel> arrOfDate = List<CalenderModel>.empty().obs;
  RxList<Attachments> arrOfImage = List<Attachments>.empty().obs;


  RxBool isDurationsEmpty = true.obs;
  RxList<ScheduleSlots> arrOfScheduleSlotTimes = List<ScheduleSlots>.empty().obs;
  RxList<DurationModel> arrOfTimeSlot = List<DurationModel>.empty().obs;
  RxList<TimeSlotModel> arrOfTimeSlotModel = List<TimeSlotModel>.empty().obs;
  Rx<ScheduleSlots> selectedScheduleSlots = ScheduleSlots().obs;
  Rx<TimeSlotModel> selectedTimeSlotModel = TimeSlotModel().obs;
  Rx<Data> selectedPetModel = Data().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  var data = Get.arguments;

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
    getPets();
    getScheduledSlots(selectedDate.value);
    generateDateList(7);
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
    }
  }

  onDurationTap(index){
    for(var item in arrOfScheduleSlotTimes){
      item.slot!.isSelected!.value = false;
    }
    if(arrOfScheduleSlotTimes[index].slot!.isSelected!.value){
      arrOfScheduleSlotTimes[index].slot!.isSelected!.value = false;
    }else{
      arrOfScheduleSlotTimes[index].slot!.isSelected!.value = true;
    }
    arrOfTimeSlotModel.value = arrOfTimeSlot[index].timeSlots!;
    selectedScheduleSlots.value = arrOfScheduleSlotTimes[index];
  }

  onSlotTap(index){
    for(var item in arrOfTimeSlotModel){
      item.isSelected!.value = false;
    }
    if(arrOfTimeSlotModel[index].isSelected!.value){
      arrOfTimeSlotModel[index].isSelected!.value = false;
    }else{
      arrOfTimeSlotModel[index].isSelected!.value = true;
    }
    selectedTimeSlotModel.value = arrOfTimeSlotModel[index];
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

  onPetSheet(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showBottomBtn: false,
          showAction: true,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "done".tr,
          actionColor: AppColors.red,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "select_pet_".tr,
          widget: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: arrOfPetType.length,
                itemBuilder: (BuildContext context, int subIndex) {
                  return PetSingleSelectionWidget(
                      model: arrOfPetType[subIndex],
                      showDivider: arrOfPetType.length-1 != subIndex,
                      onTap: () {
                        for (var item in arrOfPetType) {
                          item.isSelected!.value = false;
                        }
                        if (arrOfPetType[subIndex].isSelected!.value) {
                          arrOfPetType[subIndex].isSelected!.value = false;
                        } else {
                          arrOfPetType[subIndex].isSelected!.value = true;
                          selectedPetModel.value = arrOfPetType[subIndex];
                        }
                      });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimen.contentPadding,vertical: AppDimen.contentPadding),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.ADD_PET,arguments: {ArgumentConstants.list:arrOfPetType})!.then((value) {
                      if(value!=null) {
                        arrOfPetType.clear();
                        Util.showAlert(title: "pet_added_successfully");
                        getPets();
                      }
                    });
                  },
                  child: Row(
                    children: [
                      CommonImageView(
                        svgPath: AppImages.imgPlus,
                        width: 3.h,
                      ),
                      MyText(
                        text: "add_another".tr,
                        color: AppColors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimen.pagesVerticalPadding,)
            ],
          ),
          actionTap: () {

            RxBool isValueSelected = false.obs;
            Rx<Data> selectedItem = Data().obs;
            for(var item in arrOfPetType){
              if(item.isSelected!.value){
                selectedItem.value = item;
                isValueSelected.value = true;
              }
            }
            if(isValueSelected.value) {
              petController.value.text = "${selectedItem.value.breed!} (${selectedItem.value.name})";
            }
            Get.back();
          },
        ));
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

  onTapProceed(){

    RxBool isDurationSelected = false.obs;
    for(var item in arrOfTimeSlotModel){
      if(item.isSelected!.value){
        isDurationSelected.value = true;
      }
    }
    RxBool isSlotSelected = false.obs;
    for(var item in arrOfTimeSlotModel){
      if(item.isSelected!.value){
        isSlotSelected.value = true;
      }
    }


     if (formKey.currentState?.validate() == true) {
       if(isDurationSelected.value){
         if(isSlotSelected.value){

           if(data[ArgumentConstants.pageType] !=PageType.profile){
             scheduleAppointment();
           }else{
             if (arrOfImage.isNotEmpty) {
               scheduleAppointment();
             } else {
               Util.showToast("Please upload document");
             }
           }

         }else{
           Util.showToast("Please select slot");
         }
       }else{
         Util.showToast("Please select duration");
       }

    } else {
       if(petController.value.text.isEmpty){
         Future.delayed(const Duration(milliseconds: 100), () {
           scrollController.animateTo(
             scrollController.position.minScrollExtent,
             duration: const Duration(milliseconds: 100),
             curve: Curves.ease,
           );
         });
       }else{
         if(reasonController.value.text.isEmpty){
           Future.delayed(const Duration(milliseconds: 100), () {
             scrollController.animateTo(
               scrollController.position.maxScrollExtent,
               duration: const Duration(milliseconds: 100),
               curve: Curves.ease,
             );
           });
         }
       }


      print('not validated');
    }
  }


  Future<dynamic>  getPets({bool isRefresh = false,int? pos}) async {

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


  Future<dynamic>  getScheduledSlots(DateTime date) async {

    isDataLoading.value =  true;

    arrOfScheduleSlotTimes.clear();
    arrOfTimeSlotModel.clear();
    arrOfTimeSlot.clear();

    Map<String,dynamic> map = {
      'date':DateTimeUtil.formatDateTime(date,outputDateTimeFormat: DateTimeUtil.dateTimeFormat4),
      'relations[]':"schedule_slots",
      'vet_id':data[ArgumentConstants.id]
    };

    final result = await repository.getScheduledSlots(map);
    result.fold((l) {

      isDataLoading.value = false;

      isError.value = true;
      errorMessage.value = l.message;
      print(l);
      Util.showAlert(title: l.message);

    }, (response) {
      print(response.data.toJson());

      arrOfScheduleSlotTimes.value = response.data.scheduleSlots!;
      for(var item1 in arrOfScheduleSlotTimes){
        item1.slot!.isSelected = false.obs;
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
      isDataLoading.value = false;

    });
  }


  Future<dynamic> scheduleAppointment() async {

    Map<String,dynamic> map = {
      "slot_id": selectedScheduleSlots.value.slot!.id,
      "reason": reasonController.value.text,
      "start_time":DateTimeUtil.formatDateTime(DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, selectedTimeSlotModel.value.startTime!.hour, selectedTimeSlotModel.value.startTime!.minute), outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
      "end_time": DateTimeUtil.formatDateTime(DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day, selectedTimeSlotModel.value.endTime!.hour, selectedTimeSlotModel.value.endTime!.minute), outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
      "appointment_date": DateTimeUtil.formatDateTime(selectedDate.value, outputDateTimeFormat: DateTimeUtil.dateTimeFormat4),
      "user_pet_id": selectedPetModel.value.id,
      "vet_id": data[ArgumentConstants.id],
    };

    print(map);
    final result = await repository.scheduledAppointment(map);
    result.fold((l) {
      print(l.message);
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
      Get.toNamed(Routes.PAYMENT_DETAIL,arguments: {
        ArgumentConstants.pageType:PageType.scheduleAppointment
      });
    });
  }



}
