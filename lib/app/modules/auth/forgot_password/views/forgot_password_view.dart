import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_auth_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/custom_button.dart';
import 'package:petsvet_connect/app/components/widgets/custom_textfield.dart';
import 'package:petsvet_connect/app/modules/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:petsvet_connect/utils/helper_functions.dart';

import '../../../../components/widgets/phone_number_field.dart';
import '../../../../repository/auth_repository.dart';

class ForgotPasswordView extends StatelessWidget {

  ForgotPasswordViewModel viewModel = Get.put(ForgotPasswordViewModel(repository: Get.find<AuthRepository>()));

  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewAuthScreen(
      screenTitle: "",
      textAlign: TextAlign.center,
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "forgot_password_txt".tr,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: MyText(
                          text: viewModel.isEmail.value?"forgot_password_desc".tr:"forgot_password_desc_phone".tr,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      viewModel.isEmail.value?CustomTextField(
                        controller: viewModel.emailAddressController,
                        focusNode: viewModel.emailAddressNode,
                        hintText: "enter_email_address".tr,
                        label: "email_address".tr,
                        keyboardType: TextInputType.emailAddress,
                        isFinal: true,
                        limit: Constants.emailAddressLimit,
                        validator: (value) {
                          return HelperFunction.emailValidate(value!);
                        },
                      ):
                      Obx(() =>  PhoneNumberField(
                        mandatory:true,
                        controller: viewModel.phoneController,
                        label:"phone_number".tr,
                        focusNode: viewModel.phoneNode,
                        initialPhone: viewModel.initialPhone.value,
                        onInputChanged: (v){
                          viewModel.phoneNumber!.value = v.phoneNumber!;
                          viewModel.phoneController.refresh();
                        },),),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                  child: CustomButton(
                    label: 'continue'.tr,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    controller: viewModel.btnController,
                    onPressed: () {
                      Util.hideKeyBoard(context);
                      viewModel.forgetPasswordAPI();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
