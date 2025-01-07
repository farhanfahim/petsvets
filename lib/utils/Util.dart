import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/custom_loader.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/components/custom_toast.dart';
import '../app/components/widgets/common_image_view.dart';

class Util {
  static Future<void> launchWebView(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void showToast(String body) {
    CustomToast().showToast(body);
  }

  static String maskEmail(String? email) {
    if (email == null) return "";

    if (email.length > 6) {
      String maskedDigits = '*' * 8;
      String visibleDigits = email.substring(0, 6);
      return visibleDigits + maskedDigits;
    } else {
      return email;
    }
  }

  static String deviceType() {
    return Platform.isIOS ? "ios" : "android";
  }

  static String durationToFormattedTime(String seconds) {
    try {
      var duration = Duration(seconds: int.parse(seconds));

      String negativeSign = duration.isNegative ? '-' : '';
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
      return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } catch (e) {
      return seconds;
    }
  }
  static Future<T?> showBottomPanel<T>(BuildContext context, Widget widget,
      {bool isDismissible = true}) {
    var media = MediaQuery.of(Get.context!);
    return showModalBottomSheet<T>(
        context: context,
        backgroundColor: Colors.white,
        enableDrag: false,
        isScrollControlled: false,
        useSafeArea: false,
        isDismissible: isDismissible,
        //constraints: BoxConstraints.tight(Size.fromHeight(AppSizer.getPerHeight(1))),
        builder: (con) {
          return Padding(
            padding: EdgeInsets.only(top: media.viewPadding.top),
            child: Container(child: widget),
          );
        });
  }

  static void showAlert({required String title, bool error = false}) {
    if (title.isNotEmpty) {
      showOverlayNotification((context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w,),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppDimen.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 3.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    CommonImageView(
                      svgPath: AppImages.boldSuccess,
                      width: 6.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: MyText(
                        text: title.tr,
                        fontFamily: AppFonts.fontMulish,
                        fontWeight: FontWeight.w400,
                        color: error ? AppColors.red : AppColors.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: (){
                        OverlaySupportEntry.of(context)!.dismiss();
                      },
                      child: CommonImageView(
                        svgPath: AppImages.close,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }, duration: const Duration(seconds: 3));
    }
  }

  static void showLoader(BuildContext context) {
    Loader.show(
      context,
      progressIndicator: const CustomLoader(),
      overlayColor: AppColors.white.withOpacity(0.5),
    );
  }

  static void hideLoader() {
    Loader.hide();
  }
}

showPermissionDialog() {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "cancel".tr,
      // style: AppStyles.airBNDCerealMediumTextStyle(
      //     fontSize: AppTextSizes.textSizeSmall),
    ),
    onPressed: () {
      Get.back();
    },
  );

  Widget continueButton = TextButton(
    child: Text(
      "settings".tr,
      // style: AppStyles.airBNDCerealMediumTextStyle(
      //     fontSize: AppTextSizes.textSizeSmall),
    ),
    onPressed: () {
      Get.back();
      openAppSettings();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(
      "permission_message".tr,
      // style: AppStyles.airBNDCerealBookTextStyle(
      //     fontSize: AppTextSizes.textSizeMedium),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  Get.dialog(alert);
}
