import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import '../../../../data/enums/request_type.dart';
import '../../../../data/models/dummy_appointment_model.dart';
import '../../../../repository/vet_home_repository.dart';

class VetHomeViewModel extends GetxController {


  final VetHomeRepository repository;

  VetHomeViewModel({required this.repository});

  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;

  Rx<TextEditingController> searchController = TextEditingController().obs;
  FocusNode searchNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    generateVets();
  }

  generateVets() async {
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.both,name: "Jacob Jones",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.none,name: "Wade Warren",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.alert,name: "Albert Flores",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.both,name: "Eleanor Pena",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.flag,name: "Albert Flores",timings: "9:00 AM - 10:00 PM"));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:RequestType.alert,name: "Gretchen Korsgaard",timings: "9:00 AM - 10:00 PM",));
  }
}
