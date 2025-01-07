import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/models/local_location.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/chip_widget.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/multi_image_view.dart';
import '../../../../components/widgets/multi_selection_widget.dart';
import '../../../../components/widgets/radiobox.dart';
import '../../../../components/widgets/single_selection_widget.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/general_info_view_model.dart';

class GeneralInfoView extends StatelessWidget {

  final GeneralInfoViewModel viewModel = Get.put(GeneralInfoViewModel());

  GeneralInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      horizontalPadding:false,
      verticalPadding: false,
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset:true,
      showAppBar: false,
      hasBackButton: false.obs,
      child: Column(
        children: [
          Expanded(
            child: AbsorbPointer(
              absorbing: viewModel.absorb.value,
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                child: Form(
                  key: viewModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimen.verticalSpacing.h),
                        MyText(
                          text: "tell_a_bit".tr,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          fontSize: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: MyText(
                            text: "welcome_we_are_thrilled".tr,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: AppDimen.verticalSpacing.h),
                        MyText(
                          text: "which_you_are".tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        SizedBox(height: AppDimen.verticalPadding.h),
                        Obx(() => RadioBoxField(
                          mandatory: true,
                          initialValue:  viewModel.veterinaryMedicine.value,
                          simpleTitle: "doctor_veterinary_medicine".tr,
                          callback: (val) {
                            viewModel.veterinaryMedicine.value = true;
                            viewModel.veterinaryTechnician.value = false;
                          },
                        ),),
                        SizedBox(height: AppDimen.verticalPadding.h),
                        Obx(() => RadioBoxField(
                          mandatory: true,
                          initialValue: viewModel.veterinaryTechnician.value,
                          simpleTitle: "doctor_veterinary_technician".tr,
                          callback: (val) {
                            viewModel.veterinaryTechnician.value = true;
                            viewModel.veterinaryMedicine.value = false;
                          },
                        ),),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          controller: viewModel.stateLicenseController,
                          focusNode: viewModel.stateLicenseNode,
                          nextFocusNode: viewModel.stateNode,
                          hintText: "enter_number".tr,
                          label: "state_license_number".tr,
                          keyboardType: TextInputType.number,
                          limit: Constants.stateNumber,
                          validator: (value) {
                            return HelperFunction.validateValue(value!,"state_license_number".tr);
                          },
                        ),

                        SizedBox(height: 2.h),
                        CustomTextField(
                          controller: viewModel.stateController,
                          focusNode: viewModel.stateNode,
                          nextFocusNode: viewModel.stateNationalNode,
                          hintText: "select_state".tr,
                          label: "state_license".tr,
                          readOnly: true,
                          onTap: (){
                            BottomSheetService.showGenericBottomSheet(
                                child:  CustomBottomSheet(
                                  showHeader:true,
                                  showClose:false,
                                  showAction: true,
                                  showLeading: true,
                                  showLeadingIcon: true,
                                  showBottomBtn: false,
                                  centerTitle: true,
                                  titleSize:AppFontSize.small,
                                  leadingText: "close".tr,
                                  actionText: "save".tr,
                                  actionColor: AppColors.red,
                                  verticalPadding:AppDimen.pagesVerticalPadding,
                                  title: "select_state".tr,
                                  widget:ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:viewModel.arrOfState.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      return Column(
                                        children: [
                                          SingleSelectionWidget(
                                            showDivider: false,
                                              model:viewModel.arrOfState[index],
                                              onTap: () {
                                            for(var item in viewModel.arrOfState){
                                              item.isSelected!.value = false;
                                            }
                                            if(viewModel.arrOfState[index].isSelected!.value){
                                              viewModel.arrOfState[index].isSelected!.value = false;
                                            }else{
                                              viewModel.arrOfState[index].isSelected!.value = true;
                                              viewModel.stateController.text =  viewModel.arrOfState[index].breed!.value;
                                            }
                                          }
                                            ),

                                          Visibility(
                                            visible: viewModel.arrOfState.length-1 != index,
                                            child: Container(
                                              width: double.maxFinite,
                                              height: 0.5,
                                              color: AppColors.grey.withOpacity(0.6),
                                            ),
                                          )
                                        ],
                                      );

                                    },),

                                  actionTap: (){
                                    Get.back();
                                  },
                                  leadingTap: (){

                                    Get.back();
                                  },
                                )
                            );
                          },
                          icon: AppImages.arrowDown,
                          keyboardType: TextInputType.number,
                          limit: Constants.stateNumber,
                          validator: (value) {
                            return HelperFunction.validateValue(value!,"state_license".tr);
                          },
                        ),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          controller: viewModel.stateNationalController,
                          focusNode: viewModel.stateNationalNode,
                          nextFocusNode: viewModel.veterinaryMedicine.value?viewModel.deaNumberNode:viewModel.specializationNode,
                          hintText: "enter_number".tr,
                          label: "national_license".tr,
                          isMandatory:false,
                          keyboardType: TextInputType.number,
                          limit: Constants.stateNumber,
                        ),
                        SizedBox(height: 2.h),
                        TextFieldLabel(label: "license_documents".tr),

                        MultiImageView(showDivider:false,arrOfImage:  viewModel.arrOfImage,coverTitle: "upload_documents".tr),

                        Obx(() => Visibility(
                          visible: viewModel.veterinaryMedicine.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),
                              CustomTextField(
                                controller: viewModel.deaNumberController,
                                focusNode: viewModel.deaNumberNode,
                                nextFocusNode: viewModel.stateControlNode,
                                hintText: "enter_number".tr,
                                label: "dea_number".tr,
                                keyboardType: TextInputType.number,
                                limit: Constants.stateNumber,
                                validator: (value) {
                                  return HelperFunction.validateValue(value!,"dea_number".tr);
                                },
                              ),
                            ],
                          ),
                        ),),
                        Obx(() => Visibility(
                          visible: viewModel.veterinaryMedicine.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),

                              CustomTextField(
                                controller: viewModel.stateControlController,
                                focusNode: viewModel.stateControlNode,
                                nextFocusNode: viewModel.specializationNode,
                                hintText: "enter_number".tr,
                                label: "state_control".tr,
                                isMandatory:false,
                                keyboardType: TextInputType.number,
                                limit: Constants.stateNumber,
                              ),
                            ],
                          ),
                        ),),
                        SizedBox(height: 2.h),
                        CustomTextField(
                          controller: viewModel.specializationController,
                          focusNode: viewModel.specializationNode,
                          nextFocusNode: viewModel.aboutNode,
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
                                        isLast: viewModel.arrOfSpecialization.length-1 == index,
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
                        ),

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
                              SizedBox(height: 2.h),
                            ],
                          ),
                        ),),



                        Obx(() => Visibility(
                          visible: viewModel.veterinaryMedicine.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                controller: viewModel.aboutController,
                                focusNode: viewModel.aboutNode,
                                hintText: "tell_us_something".tr,
                                label: "about_vet".tr,
                                minLines: 5,
                                maxLines: 5,
                                onTap: (){
                                  Future.delayed(const Duration(milliseconds: 800), () {
                                    viewModel.scrollController.animateTo(
                                      viewModel.scrollController.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  });
                                },
                                isFinal:true,
                                validator: (value) {
                                  return HelperFunction.validateValue(value!,"about_vet".tr);
                                },
                                keyboardType: TextInputType.text,
                                limit: Constants.descriptionLimit,
                              ),
                            ],
                          ),
                        ),),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimen.verticalPadding.h),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

            child: CustomButton(
              label: 'next'.tr,
              textColor: AppColors.white,
              fontWeight: FontWeight.w600,
              onPressed: () {
                viewModel.onTapNext();
              },
            ),
          ),


        ],
      ),
    );
  }
}
