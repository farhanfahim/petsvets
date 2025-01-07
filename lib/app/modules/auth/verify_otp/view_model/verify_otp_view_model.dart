import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/auth_repository.dart';

class VerifyOtpViewModel extends GetxController {
  final AuthRepository repository;

  VerifyOtpViewModel({required this.repository});

  Rx<TextEditingController> otpController = TextEditingController().obs;
  RxBool isCompleted = false.obs;
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  var formKey = GlobalKey<FormState>();

  RxInt min = 00.obs;
  RxInt sec = 60.obs;
  RxBool resendOtpBool = false.obs;
  Rx<int> start = 5.obs;
  Timer? countdownTimer;
  Rx<Duration> myDuration = const Duration(seconds: 60).obs;

  var data = Get.arguments;

  String? email = "";
  String? phone = "";
  String? type = "";
  PageType? page;

  Rx<bool> absorb = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (data != null && data[ArgumentConstants.pageType] == PageType.forgotPassword) {
      page = data[ArgumentConstants.pageType];
      type = data[ArgumentConstants.type];
      if (data != null && data[ArgumentConstants.email] != null) {
        email = data[ArgumentConstants.email];
      }
      if (data != null && data[ArgumentConstants.phone] != null) {
        phone = data[ArgumentConstants.phone];
      }
    } else {
      if (data != null && data[ArgumentConstants.email] != null) {
        email = data[ArgumentConstants.email];
      }
      if (data != null && data[ArgumentConstants.phone] != null) {
        phone = data[ArgumentConstants.phone];
      }
    }

    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setCountDown(),
    );
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void resetTimer() {
    otpController.value.text = "";
    isCompleted.value = false;
    btnController.reset();
    stopTimer();
    myDuration.value = const Duration(seconds: 60);
    otpController.refresh();

    startTimer();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;

    final seconds = myDuration.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration.value = Duration(seconds: seconds);
    }
  }

  void countDown() {
    debugPrint(sec.value.toString());
    if (min.value != 0) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (sec.value != 0) {
          sec = sec - 1;
        } else {
          if (min.value != 0) {
            sec.value = 60;
            min--;
          } else {
            timer.cancel();
          }
        }
      });
    } else {
      min = 00.obs;
      sec = 60.obs;
      countDown();
    }
  }

  Future<dynamic> verifyOtpAPI() async {
    btnController.start();
    absorb.value = true;
    var data = {
      if(email!.isNotEmpty)'email': email,
      if(phone!.isNotEmpty)'phone': phone,
      'otp_code': otpController.value.text.trim(),
    };

    final result = await repository.verifyOTP(data);
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

      if (page == PageType.forgotPassword) {
        Get.toNamed(Routes.RESET_PASSWORD, arguments: {
          if(email!.isNotEmpty)ArgumentConstants.email: email,
          if(phone!.isNotEmpty)ArgumentConstants.phone: phone,
          ArgumentConstants.otpCode: otpController.value.text
        });
      } else {
        Get.offAllNamed(Routes.SUCCESS, arguments: {
          ArgumentConstants.pageType: PageType.otp,
          ArgumentConstants.message: "you_have_successfully".tr
        });
      }
    });
  }

  Future<dynamic> resendOtpAPI() async {
    resetTimer();

    print(email);
    print(phone);
    var data = {
      if(email!.isNotEmpty)'email': email,
      if(phone!.isNotEmpty)'phone': phone,
    };

    final result = await repository.resendOTP(data);
    result.fold((l) {
      print(l.message);

      Util.showAlert(title: l.message, error: true);
    }, (response) {
      Util.showAlert(title: response.message, error: false);
    });
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

}
