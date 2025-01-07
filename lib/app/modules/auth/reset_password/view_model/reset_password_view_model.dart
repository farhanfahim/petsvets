import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../utils/Util.dart';
import '../../../../repository/auth_repository.dart';

class ResetPasswordViewModel extends GetxController {
  final AuthRepository repository;

  ResetPasswordViewModel({required this.repository});

  var formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordNode = FocusNode();

  Rx<bool> showPassword = true.obs;
  Rx<bool> showConfirmPassword = true.obs;

  var data = Get.arguments;


  String? email = "";
  String? phone = "";
  String? otpCode = "";


  Rx<bool> absorb = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (data != null && data[ArgumentConstants.email] != null) {
      email = data[ArgumentConstants.email];
    }

    if (data != null && data[ArgumentConstants.phone] != null) {
      phone = data[ArgumentConstants.phone];
    }
    if (data != null && data[ArgumentConstants.otpCode] != null) {
      otpCode = data[ArgumentConstants.otpCode];
    }
  }

  Future<dynamic> onResetPasswordTap() async {
    if (formKey.currentState?.validate() == true) {
      btnController.start();
      absorb.value = true;
      var data = {
        if(email!.isNotEmpty)'email': email,
        if(phone!.isNotEmpty)'phone': phone,
        'otp_code': otpCode,
        'password': newPasswordController.text,
        'password_confirmation': confirmPasswordController.text,
      };

      final result = await repository.resetPassword(data);
      result.fold((l) {
        print(l.message);
        absorb.value = false;
        Util.showAlert(title: l.message, error: true);

        btnController.error();
        btnController.reset();
      }, (response) {
        absorb.value = false;
        btnController.success();
        btnController.reset();
        Util.showAlert(title: response.message,error: false);
        Get.offAllNamed(Routes.LOGIN);
      });
    } else {
      print('not validated');
    }
  }


}
