import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petsvet_connect/app/modules/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/app/services/api_constants.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../utils/Util.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/auth_repository.dart';

class ForgotPasswordViewModel extends GetxController {

  final AuthRepository repository;

  ForgotPasswordViewModel({required this.repository});
  var formKey = GlobalKey<FormState>();

  TextEditingController emailAddressController = TextEditingController();
  FocusNode emailAddressNode = FocusNode();

  Rx<TextEditingController> phoneController = TextEditingController(text: "").obs;
  FocusNode phoneNode = FocusNode();
  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  RxString? phoneNumber = ''.obs;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  Rx<bool> absorb = false.obs;
  Rx<bool> isEmail = false.obs;
  Rx<bool> isPhone = false.obs;

  var data = Get.arguments;


  @override
  void onInit() {
    super.onInit();


    if (data[ArgumentConstants.type] == ArgumentConstants.email) {
      isEmail.value = true;
      isEmail.refresh();
    }else if (data[ArgumentConstants.type] == ArgumentConstants.phone) {
      isPhone.value = true;
      isPhone.refresh();
    }else{
      isEmail.value = true;
    }

  }



  Future<dynamic> forgetPasswordAPI() async {
    if (formKey.currentState?.validate() == true) {
      absorb.value = true;
      btnController.start();


      var data = {
        if(isEmail.value)'email': emailAddressController.text,
        if(isPhone.value)'phone': phoneNumber!.value
      };

      print(isEmail.value);
      print(isPhone.value);
      print(data);
      final result = await repository.forgotPassword(data);
      result.fold((l) {
        print(l.message);

        Util.showAlert(title: l.message,error: true);
        absorb.value = false;
        btnController.error();
        btnController.reset();

      }, (response) {
        absorb.value = false;
        btnController.success();
        btnController.reset();

        Get.toNamed(Routes.VERIFY_OTP, arguments: {
          ArgumentConstants.pageType: PageType.forgotPassword,
          ArgumentConstants.type: isEmail.value?ArgumentConstants.email:ArgumentConstants.phone,
          if(isEmail.value )ArgumentConstants.email: emailAddressController.text.trim(),
          if(!isEmail.value )ArgumentConstants.phone: phoneController.value.text.trim(),
        });
      });


    } else {
      print('not validated');
    }


  }
}
