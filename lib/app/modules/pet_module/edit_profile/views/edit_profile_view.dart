import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/alt_phone_number_field.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/image_picker_view.dart';
import '../../../../components/widgets/radiobox.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../components/widgets/upload_photo.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../repository/pet_edit_profile_repository.dart';
import '../../../../repository_imp/media_upload_repository_imp.dart';
import '../view_model/edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {

  var mediaRepo = Get.put<MediaUploadRepository>(MediaUploadRepositoryImpl());

  EditProfileViewModel viewModel = Get.put(EditProfileViewModel(repository: Get.find<PetEditProfileRepository>(), mediaUploadRepository: Get.find<MediaUploadRepository>()));

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
      showAppBar: true,
      showHeader: true,
      horizontalPadding: false,
      centerTitle: true,
      resizeToAvoidBottomInset: true,
      hasBackButton: true.obs,
      screenName: "edit_profile".tr,
      child: Obx(
        () => AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              SizedBox(height: AppDimen.verticalSpacing.h),

                              if (viewModel.fileImage.value == null)
                                UploadPhoto(
                                  size: 20,
                                  color: AppColors.white,
                                  onTap: _onTapImgCamera,
                                  networkImage: viewModel.userImage!.value,
                                  image: AppImages.user,) else UploadPhoto(
                                size: 20,
                                color: AppColors.white,
                                onTap: _onTapImgCamera,
                                image: AppImages.user,
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
                                nextFocusNode: viewModel.emailNode,
                                hintText: "txt_your_full_name".tr,
                                label: "txt_full_name".tr,
                                keyboardType: TextInputType.name,
                                limit: Constants.fullNameLimit,
                                validator: (value) {
                                  return HelperFunction.validateValue(value!,"txt_full_name".tr);
                                },
                              ),
                              SizedBox(height: AppDimen.verticalSpacing.h),
                              CustomTextField(
                                controller: viewModel.emailController,
                                focusNode: viewModel.emailNode,
                                hintText: "enter_email_address".tr,
                                label: "email_address".tr,
                                lableColor: AppColors.gray600,
                                readOnly: true,
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


                        SizedBox(height: AppDimen.verticalSpacing.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldLabel(label: "do_you_have_access".tr,mandatory: true,),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                RadioBoxField(
                                  initialValue:  viewModel.accessPharmacy.value,
                                  simpleTitle: "yes".tr,
                                  mandatory: true,
                                  callback: (val) {
                                    viewModel.accessPharmacy.value = true;
                                    viewModel.noAccessPharmacy.value = false;
                                  },
                                ),
                                SizedBox(width: 2.h),
                                RadioBoxField(
                                  initialValue: viewModel.noAccessPharmacy.value,
                                  simpleTitle: "no".tr,
                                  mandatory: true,
                                  callback: (val) {
                                    viewModel.noAccessPharmacy.value = true;
                                    viewModel.accessPharmacy.value = false;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'save'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  controller: viewModel.btnController,
                  onPressed: () {
                    Util.hideKeyBoard(context);
                    viewModel.onSave();
                  },
                ),
              ),
            ],
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
