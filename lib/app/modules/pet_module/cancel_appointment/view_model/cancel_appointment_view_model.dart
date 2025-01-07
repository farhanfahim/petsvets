import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../utils/Util.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../repository/cancel_appointment_repository.dart';
import '../../../../routes/app_pages.dart';

class CancelAppointmentViewModel extends GetxController {


  AppointmentData? appointmentData;
  final CancelAppointmentRepository repository;
  CancelAppointmentViewModel({required this.repository});
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  var data = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    appointmentData = data[ArgumentConstants.type];
  }


  Future<dynamic> cancelAppointmentAPI() async {
    btnController.start();
    Map<String,dynamic> data = {
      "status": 20,
    };

    final result = await repository.cancelAppointment(appointmentData!.id!,data);
    result.fold((l) {
      print(l.message);
      btnController.error();
      btnController.reset();
      Util.showAlert(title: l.message, error: true);

    }, (response) async {
      btnController.error();
      btnController.reset();
      Get.toNamed(Routes.PAYMENT_DETAIL,arguments: {
        ArgumentConstants.pageType:PageType.cancellation
      });
    });
  }




}
