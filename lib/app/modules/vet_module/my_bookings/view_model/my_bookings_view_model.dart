import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import '../../../../data/models/dummy_appointment_model.dart';

class MyBookingsViewModel extends GetxController {
  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
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
