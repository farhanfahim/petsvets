import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../utils/Util.dart';
import '../../../repository/change_password_repository.dart';

class ChangePasswordViewModel extends GetxController {

  final ChangePasswordRepository repository;

  ChangePasswordViewModel({required this.repository});

  var formKey = GlobalKey<FormState>();
  Rx<bool> absorb = false.obs;
  TextEditingController currentPasswordController = TextEditingController();
  FocusNode currentPasswordNode = FocusNode();
  TextEditingController newPasswordController = TextEditingController();
  FocusNode newPasswordNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordNode = FocusNode();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  Rx<bool> showPassword = true.obs;
  Rx<bool> showNewPassword = true.obs;
  Rx<bool> showConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }


  Future<dynamic> onChangePasswordTap() async {
    if (formKey.currentState?.validate() == true) {
      btnController.start();
      absorb.value = true;
      var data = {
        'current_password': currentPasswordController.text,
        'password': newPasswordController.text,
        'password_confirmation': confirmPasswordController.text,
      };

      final result = await repository.changePassword(data);
      result.fold((l) {
        print(l.message);

        Util.showAlert(title: l.message, error: true);
        absorb.value = false;
        btnController.error();
        btnController.reset();
      }, (response) {
        absorb.value = false;
        btnController.success();
        btnController.reset();

        Util.showAlert(title: "password_updated");
        Get.back();
      });
    } else {
      print('not validated');
    }
  }

}
