 import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/auth/login/widgets/account_type_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_auth_screen.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/app_text_styles.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatelessWidget {

  LoginViewModel viewModel = Get.put(LoginViewModel(repository: Get.find<AuthRepository>()));


  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewAuthScreen(
      showAppBar: false,
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding, vertical: AppDimen.pagesVerticalPadding),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimen.verticalSpacing.h),

                  MyText(
                    text: "txt_sign_in".tr,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: MyText(
                      text: "txt_lets_get_into".tr,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  CustomTextField(
                    controller: viewModel.emailController,
                    focusNode: viewModel.emailNode,
                    hintText: "enter_email_address".tr,
                    label: "email_address".tr,
                    keyboardType: TextInputType.emailAddress,
                    limit: Constants.emailAddressLimit,
                    validator: (value) {
                      return HelperFunction.emailValidate(value!);
                    },
                  ),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  Obx(
                    () => CustomTextField(
                      controller: viewModel.passwordController,
                      focusNode: viewModel.passwordNode,
                      hintText: 'your_password'.tr,
                      label: "password".tr,
                      isFinal: true,
                      limit: Constants.passwordLimit,
                      icon: viewModel.showPassword.value == true ? AppImages.openEye : AppImages.closedEye,
                      isPassword: viewModel.showPassword.value,
                      sufixIconOnTap: () {
                        viewModel.showPassword.value = HelperFunction.showPassword(viewModel.showPassword.value);
                      },
                      validator: (value) {
                        return HelperFunction.passwordValidateStrong(value!);
                      },
                    ),
                  ),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          BottomSheetService.showGenericBottomSheet(
                              child:  CustomBottomSheet(
                                showHeader:true,
                                showClose:false,
                                showAction: true,
                                showBottomBtn: false,
                                actionText: "cancel".tr,
                                actionColor: AppColors.gray600,
                                verticalPadding:AppDimen.pagesVerticalPadding,
                                titleSize: AppFontSize.large,
                                title: "select_action".tr,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: MyText(
                                          text: "please_choose".tr,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: AppDimen.verticalSpacing.h),
                                      GestureDetector(

                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          Get.back();
                                          Get.toNamed(Routes.FORGOT_PASSWORD,arguments: {
                                            ArgumentConstants.type:ArgumentConstants.email
                                          });
                                        },
                                        child: Container(
                                          width: 100.w,
                                          color: AppColors.white,
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: MyText(
                                            text: "via_email_address".tr,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: AppDimen.verticalSpacing.h),

                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          Get.back();
                                          Get.toNamed(Routes.FORGOT_PASSWORD,arguments: {
                                            ArgumentConstants.type:ArgumentConstants.phone
                                          });
                                        },
                                        child: Container(
                                          width: 100.w,
                                          color: AppColors.white,
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: MyText(
                                            text: "via_phone_number".tr,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: AppDimen.verticalSpacing.h),


                                    ],
                                  ),
                                ),
                                actionTap: (){
                                  Get.back();
                                },
                              )
                          );
                        },
                        child: Container(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 1.0, left: 15.0, bottom: 5.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: MyText(
                                text: "forgot_password".tr,
                                fontSize: AppFontSize.extraSmall,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  CustomButton(
                    label: 'sign_in'.tr,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    controller: viewModel.btnController,
                    onPressed: () {
                      Util.hideKeyBoard(context);
                      viewModel.onLoginTap();
                    },
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "dont_have_account".tr,
                        style: AppTextStyles.dontHaveAccountStyle(),
                        children: [
                          TextSpan(
                            text: " ",
                            style: AppTextStyles.dontHaveAccountStyle(),
                          ),
                          TextSpan(
                            text: "sign_up".tr,
                            recognizer: TapGestureRecognizer()..onTap = () {
                              BottomSheetService.showGenericBottomSheet(
                                child:  CustomBottomSheet(showBottomBtn:false,
                                  showHeader:false,
                                  widget: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppDimen.verticalSpacing.h),
                                      const Center(
                                        child: CommonImageView(
                                          svgPath: AppImages.imgBottomBar,
                                        ),
                                      ),
                                      SizedBox(height: AppDimen.verticalSpacing.h),
                                      MyText(
                                        text: "select_account_type".tr,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.black,
                                        fontSize: 20,

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: MyText(
                                          text: "choose_the_role".tr,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: AppDimen.verticalSpacing.h),
                                      ListView.builder(
                                        itemCount: viewModel.arrOfAccountType.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return AccountTypeWidget(viewModel.arrOfAccountType[index],(){
                                            for(var item in viewModel.arrOfAccountType){
                                              item.isSelected!.value = false;
                                            }
                                            if(viewModel.arrOfAccountType[index].isSelected!.value){
                                              viewModel.arrOfAccountType[index].isSelected!.value = false;
                                            }else{
                                              viewModel.arrOfAccountType[index].isSelected!.value = true;
                                              viewModel.selectedType!.value = viewModel.arrOfAccountType[index].type!;
                                            }
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding),
                                        child: Obx(
                                              () => CustomButton(
                                            label: 'done'.tr,
                                            textColor: !viewModel.checkRoleSelection().value ? AppColors.fieldsHeadingColor : AppColors.white,
                                            fontWeight: FontWeight.w600,
                                            color: !viewModel.checkRoleSelection().value ? AppColors.textFieldBorderColor : AppColors.red,
                                            //controller: viewModel.btnController,
                                            onPressed: () {
                                              if(viewModel.checkRoleSelection().value){
                                                Get.back();
                                                Get.offAllNamed(Routes.SIGNUP,arguments: {
                                                  ArgumentConstants.type:viewModel.selectedType!.value
                                                });
                                              }

                                            },
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                ), )
                              );

                            },
                            style: AppTextStyles.dontHaveAccountStyle().copyWith(fontWeight: FontWeight.w700),
                          ),
                        ]

                      ),
                      textAlign: TextAlign.left,
                    ),
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
