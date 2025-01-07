import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/enums/request_type.dart';
import 'package:petsvet_connect/app/data/models/prescription_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/widgets/chip_widget.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/multi_image_view.dart';
import '../../../../components/widgets/multi_selection_widget.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../data/models/dummy_appointment_model.dart';
import '../view_model/prescirbe_medicine_view_model.dart';

class PrescribeTile extends StatelessWidget {
  final PrescriptionModel model;
  final Function()? onTap;
  final bool? isLast;
  final bool? isFirst;
  final int? pos;

  PrescribeTile({
    required this.model,
    this.isLast,
    this.isFirst,
    this.onTap,
    this.pos,
  });

  final PrescribeMedicineViewModel prescribeMedicineViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.key,
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimen.pagesHorizontalPadding,
                vertical: AppDimen.pagesVerticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Visibility(
                 visible: isFirst!,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     MyText(text: "you_can_add_max".tr),
                     const SizedBox(
                       height: 5,
                     ),
                   ],
                 ),
               ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldLabel(
                        label: "medicine_name_".tr,
                        mandatory: true,
                      ),
                    ),
                    Visibility(
                      visible: !isFirst!,
                      child: GestureDetector(
                        onTap: (){
                          BottomSheetService.showConfirmationDialog(
                            title: "remove",
                            content: "are_you_sure_want_to_remove_prescription",
                            leftButtonText: "no",
                            rightButtonText: "yes",
                            onAgree: () async {
                              Get.back();
                              prescribeMedicineViewModel.arrOfPrescription.removeAt(pos!);
                              prescribeMedicineViewModel.arrOfPrescription.refresh();
                            },
                          );
                        },
                        child: const CommonImageView(
                          svgPath: AppImages.close,
                          color: AppColors.red,
                          width: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                CustomTextField(
                  controller: model.medicineName,
                  focusNode: model.medicineNode,
                  nextFocusNode: model.instructionNode,
                  hintText: "medicine_name_".tr,
                  keyboardType: TextInputType.name,
                  limit: Constants.fullNameLimit,
                  validator: (value) {
                    return HelperFunction.validateValue(value!, "medicine_name".tr);
                  },
                ),

                const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                CustomTextField(
                  controller: model.instruction,
                  focusNode: model.instructionNode,
                  nextFocusNode: model.frequencyNode,
                  label: "dosage_instruction".tr,
                  hintText: "dosage_instruction_".tr,
                  keyboardType: TextInputType.name,
                  limit: Constants.emailLimit,
                  validator: (value) {
                    return HelperFunction.validateValue(value!, "dosage_instruction".tr);
                  },
                ),

                const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                CustomTextField(
                  controller: model.frequency,
                  focusNode: model.frequencyNode,
                  nextFocusNode: model.timingsNode,
                  label: "frequency".tr,
                  hintText: "select_frequency".tr,
                  readOnly: true,
                  icon: AppImages.arrowDown,
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
                          actionText: "cancel".tr,
                          actionColor: AppColors.gray600,
                          verticalPadding:AppDimen.pagesVerticalPadding,
                          title: "select_frequency_".tr,
                          widget:ListView.builder(
                            shrinkWrap: true,
                            itemCount:model.arrOfFrequency!.length,
                            itemBuilder: (BuildContext context, int index) {

                              return GestureDetector(
                                  onTap: (){
                                    model.frequency!.text = model.arrOfFrequency![index].title!;
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: 5),
                                    child: MyText(text: model.arrOfFrequency![index].title!,color: AppColors.black,),
                                  ));

                            },),

                          actionTap: (){
                            Get.back();
                          },
                        )
                    );
                  },

                  keyboardType: TextInputType.name,
                  limit: Constants.emailLimit,
                  validator: (value) {
                    return HelperFunction.validateValue(value!, "frequency".tr);
                  },
                ),
                const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
                CustomTextField(
                  controller: model.timings,
                  focusNode: model.timingsNode,
                  nextFocusNode: model.specialInstructionNode,
                  hintText: "select_timings".tr,
                  label: "timings".tr,
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
                          title: "select_timings".tr,
                          widget:ListView.builder(
                            shrinkWrap: true,
                            itemCount:model.arrOfTimings!.length,
                            itemBuilder: (BuildContext context, int index) {

                              return MultiSelectionWidget(
                                hideDivider: true,
                                  model:model.arrOfTimings![index],
                                  onTap: () {

                                    if(model.arrOfTimings![index].isSelected!.value){
                                      model.arrOfTimings![index].isSelected!.value = false;
                                    }else{
                                      model.arrOfTimings![index].isSelected!.value = true;
                                    }
                                    RxBool isSelected = false.obs;
                                    for(var item in model.arrOfTimings!) {
                                      if(item.isSelected!.value){
                                        isSelected.value = true;
                                      }
                                    }
                                    if(isSelected.isTrue){
                                      model.timings!.text = "select_timings".tr;
                                    }else{
                                      model.timings!.text = "";
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
                    return HelperFunction.validateValue(value!,"timings".tr);

                  },
                  icon: AppImages.arrowDown,
                ),
                Obx(() => Visibility(
                  visible: model.arrOfTimings!.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimen.pagesVerticalPadding),
                      Obx(() => Wrap(
                        children: <Widget>[
                          for(var item in model.arrOfTimings!)
                            Visibility(
                              visible: item.isSelected!.value,
                              child: ChipWidget(
                                  model:item,
                                  onTap:(){
                                    item.isSelected!.value = false;
                                    RxBool isSelected = false.obs;
                                    for(var item in model.arrOfTimings!) {
                                      if(item.isSelected!.value){
                                        isSelected.value = true;
                                      }
                                    }
                                    if(isSelected.isTrue){
                                      model.timings!.text = "select_timings".tr;
                                    }else{
                                      model.timings!.text = "";
                                    }
                                  }),
                            ),
                        ],
                      ),),
                    ],
                  ),
                ),),
                CustomTextField(
                  controller: model.specialInstruction,
                  focusNode: model.specialInstructionNode,
                  isFinal: true,
                  isMandatory: false,
                  label: "special_instruction".tr,
                  hintText: "special_instruction_".tr,
                  keyboardType: TextInputType.name,
                  limit: Constants.emailLimit,
                ),
                const SizedBox(
                  height: AppDimen.pagesHorizontalPadding,
                ),

                MyText(text: "upload_prescription".tr,color: AppColors.black,),

                MultiImageView(
                    showTitle:false,
                    showDivider:false,
                    arrOfImage:  model.images
                    ,coverTitle: "upload".tr),


                Visibility(
                  visible: isLast! && prescribeMedicineViewModel.arrOfPrescription.length<20,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        prescribeMedicineViewModel.addNew();
                        prescribeMedicineViewModel.arrOfPrescription.refresh();
                      },
                      child: Row(
                        children: [
                          CommonImageView(
                            svgPath: AppImages.imgPlus,
                            width: 3.h,
                          ),
                          MyText(
                            text: "add_more".tr,
                            color: AppColors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    )
                  ],
                ),)
              ],
            ),
          ),
          const SizedBox(height: AppDimen.pagesVerticalPaddingNew),
        ],
      ),
    );
  }
}
