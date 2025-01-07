import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/custom_textfield.dart';
import '../../../repository/change_password_repository.dart';
import '../view_model/change_password_view_model.dart';


class ChangePasswordView extends StatelessWidget {
  ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel(repository: Get.find<ChangePasswordRepository>()));


  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        centerTitle: true,
        screenName: "change_password".tr,
        child: AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MyText(
                    text: "your_new_password".tr,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 3.h),
                Obx(() => CustomTextField(
                  controller: viewModel.currentPasswordController,
                  focusNode: viewModel.currentPasswordNode,
                  nextFocusNode: viewModel.newPasswordNode,
                  hintText: 'enter_current_password'.tr,
                  label: "lbl_current_password".tr,
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
                  controller: viewModel.newPasswordController,
                  focusNode: viewModel.newPasswordNode,
                  nextFocusNode: viewModel.confirmPasswordNode,
                  hintText: 'enter_your_new_password'.tr,
                  label: "new_password".tr,
                  limit: Constants.passwordLimit,
                  isFinal: false,
                  icon: viewModel.showNewPassword.value == true ? AppImages.openEye : AppImages.closedEye,
                  isPassword: viewModel.showNewPassword.value,
                  sufixIconOnTap: () {
                    viewModel.showNewPassword.value = HelperFunction.showPassword(viewModel.showNewPassword.value);
                  },
                  validator: (value) {
                    return HelperFunction.confirmNewPasswordValidate(value!,viewModel.currentPasswordController.text);
                  },
                )),
                SizedBox(height: AppDimen.verticalSpacing.h),
                Obx(() => CustomTextField(
                  controller: viewModel.confirmPasswordController,
                  focusNode: viewModel.confirmPasswordNode,
                  hintText: 're_enter_your_new_password'.tr,
                  label: "confirm_new_password".tr,
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
                SizedBox(height: 4.h),
                CustomButton(
                  label: 'update'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  controller: viewModel.btnController,
                  onPressed: () {
                    Util.hideKeyBoard(context);
                    viewModel.onChangePasswordTap();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
