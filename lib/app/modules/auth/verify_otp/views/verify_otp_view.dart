import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_auth_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/custom_button.dart';
import 'package:petsvet_connect/app/modules/auth/verify_otp/view_model/verify_otp_view_model.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/app_text_styles.dart';
import 'package:petsvet_connect/utils/dimens.dart';

import '../../../../data/enums/page_type.dart';
import '../../../../repository/auth_repository.dart';

class VerifyOtpView extends StatelessWidget {
  VerifyOtpViewModel viewModel = Get.put(VerifyOtpViewModel(repository: Get.find<AuthRepository>()));

  VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    return BaseViewAuthScreen(
      screenTitle: '',
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    MyText(
                      text: "otp_verification".tr,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      fontSize: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: viewModel.page == PageType.signIn?RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "account_verification_txt".tr,
                          style: AppTextStyles.accountVerification(),
                          children: [
                            TextSpan(
                              text: " \n${viewModel.type == ArgumentConstants.email? viewModel.email:Util.maskEmail(viewModel.phone)}",
                              style: AppTextStyles.maskEmail(),
                            )
                          ],
                        ),
                      ):RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "account_verification_txt".tr,
                          style: AppTextStyles.accountVerification(),
                          children: [
                            TextSpan(
                              text: "\n${viewModel.email}",
                              style: AppTextStyles.maskEmail(),
                            ),
                            TextSpan(
                              text: viewModel.page == PageType.forgotPassword?"":" & ",
                              style: AppTextStyles.accountVerification(),
                            ),
                            TextSpan(
                              text: Util.maskEmail(viewModel.phone),
                              style: AppTextStyles.maskEmail(),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: Obx(() => PinCodeTextField(
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          keyboardType: TextInputType.number,
                          enabled: viewModel.myDuration.value.inSeconds != 0,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(AppDimen.borderRadius),
                            fieldHeight: 12.w,
                            fieldWidth: 12.w,
                            activeFillColor: AppColors.fieldsBgColor,
                            activeColor: AppColors.fieldsBgColor,
                            inactiveColor: AppColors.textFieldBorderColor,
                            inactiveBorderWidth: 1,
                            activeBorderWidth: 1,
                            disabledBorderWidth: 1,
                            disabledColor: AppColors.textFieldBorderColor,
                            inactiveFillColor: AppColors.fieldsBgColor,
                            selectedColor: AppColors.textFieldBorderColor,
                            selectedFillColor: AppColors.fieldsBgColor,
                          ),
                          hintCharacter: '-',
                          hintStyle: TextStyle(color: viewModel.myDuration.value.inSeconds != 0?AppColors.gray600:AppColors.textFieldBorderColor),
                          cursorColor: AppColors.black,
                          textStyle: AppTextStyles.pinCode(),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.white,
                          enableActiveFill: true,
                          controller: viewModel.otpController.value,
                          onCompleted: (v) {
                            print("Completed");
                            viewModel.isCompleted.value = true;
                            Util.hideKeyBoard(context);
                          },
                          onChanged: (value) {
                            if(value.length>3){
                              viewModel.isCompleted.value = true;
                            }else{
                              viewModel.isCompleted.value = false;
                            }
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: context,
                        ),)
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MyText(
                          text: 'expires_in'.tr,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          fontSize: AppFontSize.extraSmall,
                        ),
                        Obx(
                              () => MyText(
                            text: ' ${strDigits(viewModel.myDuration.value.inMinutes)}:${strDigits(viewModel.myDuration.value.inSeconds.remainder(60))}',
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppFontSize.extraSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    Obx(
                          () => Visibility(visible: viewModel.myDuration.value.inSeconds == 0 ? true : false, child: SizedBox(height: 2.h)),
                    ),
                    Obx(
                          () => Visibility(
                        visible: viewModel.myDuration.value.inSeconds == 0 ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0.5),
                              child: MyText(
                                text: "didnt_recv_code".tr,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                fontSize: AppFontSize.extraSmall,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                viewModel.resendOtpAPI();
                              },
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
                                child: MyText(
                                  text: 'resend'.tr,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: AppFontSize.extraSmall,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Obx(
                () => Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                  child: CustomButton(
                    label: 'verify_now'.tr,
                    textColor: !viewModel.isCompleted.value ? AppColors.fieldsHeadingColor : AppColors.white,
                    fontWeight: FontWeight.w600,
                    color: !viewModel.isCompleted.value ? AppColors.textFieldBorderColor : AppColors.red,
                    controller: viewModel.btnController,
                    onPressed: () {
                      if(viewModel.isCompleted.value){
                        Util.hideKeyBoard(context);
                        viewModel.verifyOtpAPI();
                      }

                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
