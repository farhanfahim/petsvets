import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:petsvet_connect/app/modules/vet_post_registration/general_info/view_model/general_info_view_model.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../data/models/add_vet_model.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../repository/vet_post_registration_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../account_setup/view_model/vet_account_setup_view_model.dart';

class PaymentViewModel extends GetxController {
  final VetPostRegistrationRepository repository;
  PaymentViewModel({required this.repository,});


  final VetAccountSetupViewModel accountSetupViewModel = Get.find();

  final GeneralInfoViewModel generalInfoViewModel = Get.find();
  TextEditingController startTimeController = TextEditingController(text: "");
  FocusNode startTimeNode = FocusNode();
  TextEditingController endTimeController = TextEditingController(text: "");
  FocusNode endTimeNode = FocusNode();
  RxList<LicenseDocuments> awsUrl = List<LicenseDocuments>.empty().obs;

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  Rx<DateTime>? startSelectedTime;
  Rx<DateTime>? endSelectedTime;

  Rx<AddVetModel> model = AddVetModel().obs;

  RxList<PetTypeModel> arrOfPayment = List<PetTypeModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    arrOfPayment.add(PetTypeModel(title: "",breed:"Paypal".obs,isSelected:false.obs));
  }


  void onDoneTap() {
    if(arrOfPayment[0].isSelected!.value) {

      addRecordAPI();

    }else{
      Util.showToast("Please select payment");
    }
  }


  Future<dynamic> addRecordAPI() async {
    btnController.start();

    model.value = AddVetModel(
        vetType: generalInfoViewModel.veterinaryMedicine.value?10:20, //10 veterinary Medicine, 20 veterinary Technician
        stateLicenseNumber:generalInfoViewModel.stateLicenseController.text,
        stateLicense: generalInfoViewModel.stateController.text,
        nationalLicenseNumber: generalInfoViewModel.stateNationalController.text,
        deaNumber: generalInfoViewModel.deaNumberController.text,
        licenseDocuments: generalInfoViewModel.arrOfSelectedImages,
        vetSpecializations: generalInfoViewModel.arrSelectedOfSpecialization,
        regNumber: generalInfoViewModel.stateControlController.text,
        about: generalInfoViewModel.aboutController.text,
        startTime: DateTimeUtil.formatDate(startTimeController.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
        endTime: DateTimeUtil.formatDate(endTimeController.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),


    );
    log(jsonEncode(model.toJson()));
    final result = await repository.addVetRecord(model.value.toJson());
    result.fold((l) {
      print(l.message);

      Util.showAlert(title: l.message,error: true);

      btnController.error();
      btnController.reset();

    }, (response) {
      btnController.success();
      btnController.reset();
        Get.offAllNamed(Routes.SUCCESS, arguments: {
        ArgumentConstants.pageType:PageType.payment,
        ArgumentConstants.message: "once_the_admin_confirms".tr
      });
    });


  }


  onTapBack(){
    accountSetupViewModel.previousPage();
  }
}
