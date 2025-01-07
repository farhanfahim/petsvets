import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_auth_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/custom_button.dart';
import 'package:petsvet_connect/app/components/widgets/custom_textfield.dart';
import 'package:petsvet_connect/app/modules/auth/reset_password/view_model/reset_password_view_model.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:petsvet_connect/utils/helper_functions.dart';

import '../../../../repository/auth_repository.dart';

class ResetPasswordView extends StatelessWidget {

  ResetPasswordViewModel viewModel = Get.put(ResetPasswordViewModel(repository: Get.find<AuthRepository>()));

  ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewAuthScreen(
      screenTitle: '',
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding, vertical: AppDimen.pagesHorizontalPadding),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "reset_password".tr,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: MyText(
                      text: "reset_password_desc".tr,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Obx(() => CustomTextField(
                        controller: viewModel.newPasswordController,
                        focusNode: viewModel.newPasswordNode,
                        nextFocusNode: viewModel.confirmPasswordNode,
                        hintText: 'your_password'.tr,
                        label: "password".tr,
                        limit: Constants.passwordLimit,
                        isFinal: false,
                        icon: viewModel.showPassword.value == true ? AppImages.openEye : AppImages.closedEye,
                        isPassword: viewModel.showPassword.value,
                        sufixIconOnTap: () {
                          viewModel.showPassword.value = HelperFunction.showPassword(viewModel.showPassword.value);
                        },
                        validator: (value) {
                          return HelperFunction.passwordValidateStrong(value!);
                        },
                      )),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  Obx(() => CustomTextField(
                        controller: viewModel.confirmPasswordController,
                        focusNode: viewModel.confirmPasswordNode,
                        hintText: 'your_confirm_password'.tr,
                        label: "confirm_password".tr,
                        limit: Constants.passwordLimit,
                        isFinal: true,
                        icon: viewModel.showConfirmPassword.value == true ? AppImages.openEye : AppImages.closedEye,
                        isPassword: viewModel.showConfirmPassword.value,
                        sufixIconOnTap: () {
                          viewModel.showConfirmPassword.value = HelperFunction.showPassword(viewModel.showConfirmPassword.value);
                        },
                        validator: (value) {
                          return HelperFunction.confirmPasswordValidate(value!, viewModel.newPasswordController.text);
                        },
                      )),
                  const Spacer(),
                  CustomButton(
                    label: 'reset_password'.tr,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    controller: viewModel.btnController,
                    onPressed: () {
                      Util.hideKeyBoard(context);
                      viewModel.onResetPasswordTap();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
