import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/components/widgets/single_selection_widget.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/alt_phone_number_field.dart';
import '../../../../components/widgets/chip_widget.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/image_picker_view.dart';
import '../../../../components/widgets/multi_selection_widget.dart';
import '../../../../components/widgets/upload_photo.dart';
import '../../../../data/models/location.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../repository/vet_edit_profile_repository.dart';
import '../../../../repository_imp/media_upload_repository_imp.dart';
import '../view_model/vet_edit_profile_view_model.dart';

class VetEditProfileView extends StatelessWidget {

  var mediaRepo = Get.put<MediaUploadRepository>(MediaUploadRepositoryImpl());

  VetEditProfileViewModel viewModel = Get.put(VetEditProfileViewModel(repository: Get.find<VetEditProfileRepository>(), mediaUploadRepository: Get.find<MediaUploadRepository>()));

  VetEditProfileView({super.key});

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
                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),

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
                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
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
                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                              CustomTextField(
                                controller: viewModel.emailController,
                                focusNode: viewModel.emailNode,
                                hintText: "enter_email_address".tr,
                                label: "email_address".tr,
                                lableColor: AppColors.gray600,
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                limit: Constants.emailLimit,
                                nextFocusNode: viewModel.addressNode,
                                validator: (value) {
                                  return HelperFunction.emailValidate(value!);
                                },
                              ),
                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                              CustomTextField(
                                controller: viewModel.addressController,
                                focusNode: viewModel.addressNode,
                                nextFocusNode: viewModel.phoneNode,
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
                                  Get.toNamed(Routes.ADD_LOCATION_PCIKER)!.then((value) {
                                    if(value!=null) {
                                      var address = value as Location;
                                      viewModel.addressController.text = address.address;
                                      viewModel.lat!.value = address.latitude;
                                      viewModel.lng!.value = address.longitude;
                                    }
                                  });
                                },
                                limit: Constants.addressLimit,
                                validator: (value) {
                                  return HelperFunction.validateValue(value!,"clinic_address".tr);
                                },
                              ),

                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                              Obx(() => AltPhoneNumberField(
                                mandatory:true,
                                controller: viewModel.phoneController,
                                controller2: viewModel.altPhoneController,
                                label:"phone_number".tr,
                                focusNode: viewModel.phoneNode,
                                initialPhone: viewModel.initialPhone.value,
                                onInputChanged: (v){
                                  viewModel.phoneNumber!.value = v.phoneNumber.toString();
                                  viewModel.phoneController.refresh();
                                },),),
                              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
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
                            viewModel.altPhoneNumber!.value = v.phoneNumber.toString();
                            viewModel.altPhoneNumber!.refresh();
                          },),),


                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                        CustomTextField(
                          controller: viewModel.deaNumberController,
                          focusNode: viewModel.deaNumberNode,
                          nextFocusNode: viewModel.specializationNode,
                          hintText: "enter_number".tr,
                          label: "dea_number".tr,
                          isMandatory: false,
                          keyboardType: TextInputType.number,
                          limit: Constants.stateNumber,
                        ),

                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                       Form(
                         key: viewModel.formKey1,
                         child:  CustomTextField(
                         controller: viewModel.specializationController,
                         focusNode: viewModel.specializationNode,
                         nextFocusNode: viewModel.doctorTypeNode,
                         hintText: "select_specialize".tr,
                         label: "are_you_specialized".tr,
                         lableColor:AppColors.gray600,
                         keyboardType: TextInputType.number,
                         limit: Constants.stateNumber,
                         readOnly: true,
                         onTap: (){
                           BottomSheetService.showGenericBottomSheet(
                               child:  CustomBottomSheet(
                                 showHeader:true,
                                 showClose:false,
                                 showAction: true,
                                 showLeading: false,
                                 showLeadingIcon: false,
                                 showBottomBtn: false,
                                 centerTitle: false,
                                 titleSize:AppFontSize.small,
                                 leadingText: "close".tr,
                                 actionText: "done".tr,
                                 actionColor: AppColors.red,
                                 verticalPadding:AppDimen.pagesVerticalPadding,
                                 title: "select_specialize".tr,
                                 widget:ListView.builder(
                                   shrinkWrap: true,
                                   itemCount:viewModel.arrOfSpecialization.length,
                                   itemBuilder: (BuildContext context, int index) {

                                     return MultiSelectionWidget(
                                         isLast:viewModel.arrOfSpecialization.length-1 == index,
                                         model:viewModel.arrOfSpecialization[index],
                                         onTap: () {

                                           if(viewModel.arrOfSpecialization[index].isSelected!.value){
                                             viewModel.arrOfSpecialization[index].isSelected!.value = false;
                                           }else{
                                             viewModel.arrOfSpecialization[index].isSelected!.value = true;
                                           }
                                           RxBool isSelected = false.obs;
                                           for(var item in viewModel.arrOfSpecialization) {
                                             if(item.isSelected!.value){
                                               isSelected.value = true;
                                             }
                                           }
                                           if(isSelected.isTrue){
                                             viewModel.specializationController.text = "select_specialize".tr;
                                           }else{
                                             viewModel.specializationController.text = "";
                                           }
                                         });

                                   },),

                                 actionTap: (){
                                   Get.back();
                                 },
                               )
                           );
                         },

                         validator: (value) {
                           return HelperFunction.validateValue(value!,"specialization".tr);

                         },
                         icon: AppImages.arrowDown,
                       ),),
                        Obx(() => Visibility(
                          visible: viewModel.arrOfSpecialization.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.h),
                              Obx(() => Wrap(
                                children: <Widget>[
                                  for(var item in viewModel.arrOfSpecialization)
                                    Visibility(
                                      visible: item.isSelected!.value,
                                      child: ChipWidget(
                                          model:item,
                                          onTap:(){
                                            item.isSelected!.value = false;
                                            RxBool isSelected = false.obs;
                                            for(var item in viewModel.arrOfSpecialization) {
                                              if(item.isSelected!.value){
                                                isSelected.value = true;
                                              }
                                            }
                                            if(isSelected.isTrue){
                                              viewModel.specializationController.text = "select_specialize".tr;
                                            }else{
                                              viewModel.specializationController.text = "";
                                            }
                                          }),
                                    ),
                                ],
                              ),),

                            ],
                          ),
                        ),),
                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                        CustomTextField(
                          controller: viewModel.doctorTypeController,
                          focusNode: viewModel.doctorTypeNode,
                          hintText: "doctor_of_veterinary".tr,
                          label: "which_one_you_are".tr,
                          isMandatory: false,
                          isFinal: true,
                          keyboardType: TextInputType.number,
                          limit: Constants.stateNumber,
                          readOnly: true,
                          onTap: (){
                            BottomSheetService.showGenericBottomSheet(
                                child:  CustomBottomSheet(
                                  showHeader:true,
                                  showClose:false,
                                  showAction: true,
                                  showLeading: false,
                                  showLeadingIcon: false,
                                  showBottomBtn: false,
                                  centerTitle: false,
                                  titleSize:AppFontSize.small,
                                  leadingText: "close".tr,
                                  actionText: "done".tr,
                                  actionColor: AppColors.red,
                                  verticalPadding:AppDimen.pagesVerticalPadding,
                                  title: "select_type".tr,
                                  widget:ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:viewModel.arrOfDoctorType.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      return SingleSelectionWidget(
                                          model:viewModel.arrOfDoctorType[index],
                                          onTap: () {
                                            for(var item in viewModel.arrOfDoctorType) {
                                               item.isSelected!.value = false;
                                            }
                                            if(viewModel.arrOfSpecialization[index].isSelected!.value){
                                              viewModel.arrOfDoctorType[index].isSelected!.value = false;
                                            }else{
                                              viewModel.arrOfDoctorType[index].isSelected!.value = true;
                                            }

                                          });

                                    },),

                                  actionTap: (){
                                    Get.back();
                                    Rx<PetTypeModel> selectedType = PetTypeModel().obs;
                                    for(var item in viewModel.arrOfDoctorType) {
                                      if(item.isSelected!.value){
                                        selectedType.value = item;
                                      }
                                    }
                                    if(selectedType.value.title!.isNotEmpty){
                                      viewModel.doctorTypeController.text = selectedType.value.title!;
                                    }else{
                                      viewModel.doctorTypeController.text = "";
                                    }
                                  },
                                )
                            );
                          },
                          icon: AppImages.arrowDown,
                        ),
                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: viewModel.startTimeController,
                                focusNode: viewModel.startTimeNode,
                                hintText: "select_start_time".tr,
                                label: "start_time".tr,
                                keyboardType: TextInputType.text,
                                limit: Constants.stateNumber,
                                isMandatory: false,
                                readOnly: true,
                                onTap: (){
                                  viewModel.startSelectedTime ??= DateTime.now();
                                  BottomSheetService.showGenericBottomSheet(
                                      child:  CustomBottomSheet(
                                        showHeader:true,
                                        showClose:false,
                                        showAction: true,
                                        showLeading: false,
                                        showLeadingIcon: false,
                                        showBottomBtn: false,
                                        centerTitle: false,
                                        titleSize:AppFontSize.small,
                                        actionText: "done".tr,
                                        actionColor: AppColors.red,
                                        verticalPadding:AppDimen.pagesVerticalPadding,
                                        title: "select_time".tr,
                                        widget:SizedBox(
                                          height: 200,
                                          width: double.maxFinite,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged: (DateTime dateTime) {
                                              viewModel.startSelectedTime = dateTime;
                                            },
                                          ),
                                        ),

                                        actionTap: (){
                                          Get.back();
                                          if(viewModel.endSelectedTime!=null){
                                            if(viewModel.startSelectedTime!.isBefore(viewModel.endSelectedTime!)){
                                              viewModel.startTimeController.text = DateTimeUtil.formatDateTime(viewModel.startSelectedTime,
                                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
                                            }else if(viewModel.startSelectedTime!.isAtSameMomentAs(viewModel.endSelectedTime!)){
                                              Util.showToast("Start time should be less than end time");

                                            }else{
                                              Util.showToast("Wrong time selection");
                                            }
                                          }else{
                                            viewModel.startTimeController.text = DateTimeUtil.formatDateTime(viewModel.startSelectedTime,
                                                outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
                                          }
                                        },
                                      )
                                  );
                                },
                                icon: AppImages.clock,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomTextField(
                                controller: viewModel.endTimeController,
                                focusNode: viewModel.endTimeNode,
                                hintText: "select_end_time".tr,
                                label: "end_time".tr,
                                keyboardType: TextInputType.text,
                                limit: Constants.stateNumber,
                                isMandatory: false,
                                readOnly: true,
                                onTap: (){
                                  viewModel.endSelectedTime ??= DateTime.now();
                                  BottomSheetService.showGenericBottomSheet(
                                      child:  CustomBottomSheet(
                                        showHeader:true,
                                        showClose:false,
                                        showAction: true,
                                        showLeading: false,
                                        showLeadingIcon: false,
                                        showBottomBtn: false,
                                        centerTitle: false,
                                        titleSize:AppFontSize.small,
                                        actionText: "done".tr,
                                        actionColor: AppColors.red,
                                        verticalPadding:AppDimen.pagesVerticalPadding,
                                        title: "select_time".tr,
                                        widget:SizedBox(
                                          height: 200,
                                          width: double.maxFinite,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.time,
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged: (DateTime dateTime) {
                                              viewModel.endSelectedTime = dateTime;
                                            },
                                          ),
                                        ),

                                        actionTap: (){
                                          Get.back();
                                          if(viewModel.startSelectedTime!=null){
                                            if(viewModel.endSelectedTime!.isAfter(viewModel.startSelectedTime!)){
                                              viewModel.endTimeController.text = DateTimeUtil.formatDateTime(viewModel.endSelectedTime,
                                                  outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);

                                            }else if(viewModel.endSelectedTime!.isAtSameMomentAs(viewModel.startSelectedTime!)){
                                              Util.showToast("End time should be greater than start time");

                                            }else{
                                              Util.showToast("Wrong time selection");
                                            }
                                          }else{
                                            viewModel.endTimeController.text = DateTimeUtil.formatDateTime(viewModel.endSelectedTime,
                                                outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
                                          }



                                        },
                                      )
                                  );
                                },
                                icon: AppImages.clock,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
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
