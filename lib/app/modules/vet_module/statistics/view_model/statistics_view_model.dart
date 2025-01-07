import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../data/models/dummy_appointment_model.dart';
import '../../../../data/models/pet_type_model.dart';

class StatisticsViewModel extends GetxController {


  RxList<DummyAppointmentModel> arrOfVets = List<DummyAppointmentModel>.empty().obs;
  RxList<PetTypeModel> arrOfDays = List<PetTypeModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    arrOfDays.add(PetTypeModel(title: "30 days",breed: "".obs,isSelected: true.obs));
    arrOfDays.add(PetTypeModel(title: "90 days",breed: "".obs,isSelected: false.obs));
    arrOfDays.add(PetTypeModel(title: "All-Time",breed: "".obs,isSelected: false.obs));
    generateVets();
  }


  generateVets() async {
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.paid,name: "Jacob Jones",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Wade Warren",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.paid,name: "Albert Flores",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.paid,name: "Eleanor Pena",timings: "9:00 AM - 10:00 PM",));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Albert Flores",timings: "9:00 AM - 10:00 PM"));
    arrOfVets.add(DummyAppointmentModel(image: AppImages.userDummyImg,type:StatusType.pending,name: "Gretchen Korsgaard",timings: "9:00 AM - 10:00 PM",));
  }

}
