import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_auth_screen.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../../utils/app_text_styles.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/alt_phone_number_field.dart';
import '../../../../components/widgets/checkbox.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/image_picker_view.dart';
import '../../../../components/widgets/radiobox.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../components/widgets/upload_photo.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../repository_imp/media_upload_repository_imp.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  var mediaRepo = Get.put<MediaUploadRepository>(MediaUploadRepositoryImpl());

  SignUpViewModel viewModel = Get.put(SignUpViewModel(repository: Get.find<AuthRepository>(), mediaUploadRepository: Get.find<MediaUploadRepository>()));

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewAuthScreen(
      showAppBar: false,
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppDimen.horizontalPadding.w, vertical: AppDimen.verticalPadding.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: AppDimen.verticalSpacing.h),

                      MyText(
                        text: "sign_up".tr,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: MyText(
                          text: "enter_your_detail".tr,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      UploadPhoto(
                        color: AppColors.gray600.withOpacity(0.6),
                        onTap: _onTapImgCamera,

                        fileImage: viewModel.fileImage.value,
                      ),
                      const SizedBox(height: 5),
                      MyText(
                        text: "upload_photo".tr,
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      CustomTextField(
                        controller: viewModel.nameController,
                        focusNode: viewModel.nameNode,
                        nextFocusNode: viewModel.addressNode,
                        hintText: "txt_your_full_name".tr,
                        label: "txt_full_name".tr,
                        keyboardType: TextInputType.name,
                        limit: Constants.fullNameLimit,
                        validator: (value) {
                          return HelperFunction.validateValue(value!,"txt_full_name".tr);
                        },
                      ),
                      Visibility(
                          visible: viewModel.page == AccountType.vet?true:false,
                          child: SizedBox(height: AppDimen.verticalSpacing.h)),
                      Visibility(
                        visible: viewModel.page == AccountType.vet?true:false,
                        child: CustomTextField(
                          controller: viewModel.addressController,
                          focusNode: viewModel.addressNode,
                          nextFocusNode: viewModel.emailNode,
                          hintText: "enter_your_clinic_address".tr,
                          label: "clinic_address".tr,
                          readOnly: true,
                          keyboardType: TextInputType.streetAddress,
                          suffixWidget: const Padding(
                            padding: EdgeInsets.all(10),
                            child: CommonImageView(
                              svgPath: AppImages.location,
                              width: 18,
                            ),
                          ),
                          onTap: (){

                            Get.toNamed(Routes.ADD_LOCATION_PCIKER,arguments: false)!.then((value) {
                              if(value!=null) {
                                viewModel.selectedAddress.value = value;
                                viewModel.addressController.text = viewModel.selectedAddress.value.address!;
                              }
                            });
                          },
                          limit: Constants.addressLimit,
                          validator: (value) {
                            return HelperFunction.validateValue(value!,"clinic_address".tr);
                          },
                        ),
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      CustomTextField(
                        controller: viewModel.emailController,
                        focusNode: viewModel.emailNode,
                        hintText: "enter_email_address".tr,
                        label: "email_address".tr,
                        keyboardType: TextInputType.emailAddress,
                        limit: Constants.emailAddressLimit,
                        nextFocusNode: viewModel.phoneNode,
                        validator: (value) {
                          return HelperFunction.emailValidate(value!);
                        },
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      Obx(() => AltPhoneNumberField(
                        mandatory:true,
                        controller: viewModel.phoneController,
                        controller2: viewModel.altPhoneController,
                        label:"phone_number".tr,
                        focusNode: viewModel.phoneNode,
                        initialPhone: viewModel.initialPhone.value,
                        onInputChanged: (v){
                          viewModel.phoneNumber!.value = v.phoneNumber!;
                          viewModel.phoneController.refresh();
                        },),),

                      SizedBox(height: AppDimen.verticalSpacing.h),
                    ],
                  ),
                ),
                Obx(() => AltPhoneNumberField(
                  mandatory:false,
                  controller: viewModel.altPhoneController,
                  controller2: viewModel.phoneController,
                  label:"alt_phone_number".tr,
                  focusNode: viewModel.altPhoneNode,
                  initialPhone: viewModel.altInitialPhone.value,
                  onInputChanged: (v){
                    viewModel.altPhoneNumber!.value = v.phoneNumber!;
                    viewModel.altPhoneNumber!.refresh();
                  },),),
                Form(
                  key: viewModel.formKey1,
                  child: Column(
                    children: [
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      Obx(
                            () => CustomTextField(
                          controller: viewModel.passwordController,
                          focusNode: viewModel.passwordNode,
                          hintText: 'your_password'.tr,
                          label: "password".tr,
                          nextFocusNode: viewModel.confirmPasswordNode,
                          limit: Constants.passwordLimit,
                          icon: viewModel.showPassword.value == true ? AppImages.closedEye : AppImages.openEye,
                          isPassword: viewModel.showPassword.value,
                          sufixIconOnTap: () {
                            viewModel.showPassword.value = HelperFunction.showPassword(viewModel.showPassword.value);
                          },
                          validator: (value) {
                            return HelperFunction.passwordValidateStrong(value!, );
                          },
                        ),
                      ),
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      Obx(() => CustomTextField(
                        controller: viewModel.confirmPasswordController,
                        focusNode: viewModel.confirmPasswordNode,
                        hintText: 'your_confirm_password'.tr,
                        label: "confirm_password".tr,
                        limit: Constants.passwordLimit,
                        isFinal: true,
                        icon: viewModel.showConfirmPassword.value == true ? AppImages.closedEye : AppImages.openEye,
                        isPassword: viewModel.showConfirmPassword.value,
                        sufixIconOnTap: () {
                          viewModel.showConfirmPassword.value = HelperFunction.showPassword(viewModel.showConfirmPassword.value);
                        },
                        validator: (value) {
                          return HelperFunction.confirmPasswordValidate(value!, viewModel.passwordController.text);
                        },
                      )),
                    ],
                  ),
                ),
                SizedBox(height: AppDimen.verticalSpacing.h),
                Visibility(
                  visible: viewModel.page == AccountType.pet?true:false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLabel(label: "do_you_have_access".tr,mandatory: true,),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          RadioBoxField(
                            initialValue:  viewModel.accessPharmacy.value,
                            simpleTitle: "yes".tr,
                            callback: (val) {
                              viewModel.accessPharmacy.value = val;
                              viewModel.noAccessPharmacy.value = false;
                            },
                          ),
                          SizedBox(width: 2.h),
                          RadioBoxField(
                            initialValue: viewModel.noAccessPharmacy.value,
                            simpleTitle: "no".tr,
                            callback: (val) {
                              viewModel.noAccessPharmacy.value = val;
                              viewModel.accessPharmacy.value = false;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),

                CheckBoxField(
                  isRichText: true,
                  initialValue: viewModel.isCheckTerms.value,
                  richText1: "by_creating".tr,
                  richText2: "lbl_terms_conditions".tr,
                  richText3: "lbl_privacy_policy".tr,
                  richTextCallBack: (String val) {
                    if (val == "lbl_terms_conditions".tr) {
                      Get.toNamed(Routes.PAGE,
                          arguments: { ArgumentConstants.pageType: PageType.terms,});
                    } else {
                      Get.toNamed(Routes.PAGE,
                          arguments: { ArgumentConstants.pageType: PageType.privacy,});
                    }
                  },
                  callback: (val) {
                    viewModel.isCheckTerms.value = val;
                    viewModel.isCheckTerms.refresh();
                  },
                ),
                SizedBox(height: AppDimen.verticalSpacing.h),
                Visibility(
                  visible: viewModel.page == AccountType.pet?true:false,
                  child: CheckBoxField(
                    isRichText: false,
                    initialValue: viewModel.isSharePetRecords.value,
                    simpleTitle:"i_agree_to_share".tr,
                    callback: (val) {
                      viewModel.isSharePetRecords.value = val;
                    },
                  ),
                ),
                SizedBox(height: 5.h),
                CustomButton(
                  label: 'sign_up'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  controller: viewModel.btnController,
                  onPressed: () {
                    Util.hideKeyBoard(context);
                    viewModel.onSignUpTap();
                  },
                ),
                SizedBox(height: 4.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "already_have_account".tr,
                      style: AppTextStyles.dontHaveAccountStyle(),
                      children: [
                        TextSpan(
                          text: " ",
                          style: AppTextStyles.dontHaveAccountStyle(),
                        ),
                        TextSpan(
                          text: "sign_in".tr,
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Get.offAllNamed(Routes.LOGIN);
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
    );
  }

  void _onTapImgCamera() async {
    BottomSheetService.showGenericBottomSheet(
      child: ImagePickerView(
        takePictureTap: () {
          viewModel.pickImageFromCamera();
        },
        uploadPictureTap: () {
          viewModel.pickImageFromGallery();
        },
      ),
    );
  }
}
