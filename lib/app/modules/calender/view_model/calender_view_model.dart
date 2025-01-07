import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/custom_dialog.dart';
import '../../../data/enums/status_type.dart';
import '../../../data/models/dummy_appointment_model.dart';

class CalenderViewModel extends GetxController {

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<CalendarFormat> format = CalendarFormat.month.obs;
  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;

  RxString role = "".obs;
  RxBool calendarOpened = true.obs;


  RxList<DateTime> markDates = RxList();

  var data = Get.arguments;


  @override
  void onInit() {
    super.onInit();
    role.value = AppPreferences.getRole();
    generateVets();

  }

  generateVets() async {
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Jacob Jones",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.cancelled,name: "Wade Warren",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.confirmed,name: "Albert Flores",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Eleanor Pena",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.confirmed,name: "Albert Flores",timings: "9:00 AM - 10:00 PM"));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Gretchen Korsgaard",timings: "9:00 AM - 10:00 PM",));
  }


}
