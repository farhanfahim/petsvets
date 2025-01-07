import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class VetAppointmentHistoryViewModel extends GetxController {
  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    generateVets();
  }

  generateVets() async {
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Jacob Jones",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Wade Warren",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Albert Flores",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Eleanor Pena",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Albert Flores",timings: "9:00 AM - 10:00 PM"));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.completed,name: "Gretchen Korsgaard",timings: "9:00 AM - 10:00 PM",));
  }
}
