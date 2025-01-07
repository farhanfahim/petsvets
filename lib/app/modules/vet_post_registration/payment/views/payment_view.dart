import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/single_selection_widget.dart';
import '../../../../repository/vet_post_registration_repository.dart';
import '../view_model/payment_view_model.dart';

class PaymentView extends StatelessWidget {

  PaymentViewModel viewModel = Get.put(PaymentViewModel(repository: Get.find<VetPostRegistrationRepository>()));

  PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      horizontalPadding:false,
      backgroundColor: AppColors.white,
      verticalPadding:false,
      resizeToAvoidBottomInset:true,
      showAppBar: false,
      hasBackButton: false.obs,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: AppDimen.verticalSpacing.h),
                       MyText(
                         text: "working_hours".tr,
                         fontWeight: FontWeight.w600,
                         color: AppColors.black,
                         fontSize: 16,
                       ),
                       SizedBox(height: 1.h),

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
                                 viewModel.startSelectedTime ??= DateTime.now().obs;
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
                                             viewModel.startSelectedTime = dateTime.obs;
                                           },
                                         ),
                                       ),

                                       actionTap: (){
                                         Get.back();
                                         if(viewModel.endSelectedTime!=null){
                                           if(viewModel.startSelectedTime!.value.isBefore(viewModel.endSelectedTime!.value)){
                                             viewModel.startTimeController.text = DateTimeUtil.formatDateTime(viewModel.startSelectedTime!.value,
                                                 outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
                                           }else if(viewModel.startSelectedTime!.value.isAtSameMomentAs(viewModel.endSelectedTime!.value)){
                                             Util.showToast("Start time should be less than end time");

                                           }else{
                                             Util.showToast("Wrong time selection");
                                           }
                                         }else{
                                           viewModel.startTimeController.text = DateTimeUtil.formatDateTime(viewModel.startSelectedTime!.value,
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
                                 viewModel.endSelectedTime ??= DateTime.now().obs;
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
                                             viewModel.endSelectedTime = dateTime.obs;
                                           },
                                         ),
                                       ),

                                       actionTap: (){
                                         Get.back();
                                         if(viewModel.startSelectedTime!=null){
                                           if(viewModel.endSelectedTime!.value.isAfter(viewModel.startSelectedTime!.value)){
                                             viewModel.endTimeController.text = DateTimeUtil.formatDateTime(viewModel.endSelectedTime!.value,
                                                 outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);

                                           }else if(viewModel.endSelectedTime!.value.isAtSameMomentAs(viewModel.startSelectedTime!.value)){
                                             Util.showToast("End time should be greater than start time");

                                           }else{
                                             Util.showToast("Wrong time selection");
                                           }
                                         }else{
                                           viewModel.endTimeController.text = DateTimeUtil.formatDateTime(viewModel.endSelectedTime!.value,
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
                       SizedBox(height: AppDimen.verticalSpacing.h),
                       MyText(
                         text: "platform_fee".tr,
                         fontWeight: FontWeight.w600,
                         color: AppColors.black,
                         fontSize: 16,
                       ),
                       SizedBox(height: 1.h),

                       Row(
                         children: [
                           Expanded(
                             child: MyText(
                               text: "total_amount".tr,
                               fontWeight: FontWeight.w400,
                               color: AppColors.black,
                               fontSize: 14,
                             ),
                           ),
                           const MyText(
                             text: "\$250",
                             fontWeight: FontWeight.w400,
                             color: AppColors.black,
                             fontSize: 16,
                           ),
                         ],
                       ),
                       const SizedBox(height: 5),
                       MyText(
                         text: "note_its_a_one_time_payment".tr,
                         fontWeight: FontWeight.w400,
                         color: AppColors.grey,
                         fontSize: 14,
                       ),
                     ],
                   ),
                 ),

                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: double.maxFinite,
                    height: 0.5,
                    color: AppColors.grey.withOpacity(0.6),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimen.verticalSpacing.h),
                        MyText(
                          text: "select_payment_method".tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                        SizedBox(height: 1.h),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:viewModel.arrOfPayment.length,
                          itemBuilder: (BuildContext context, int index) {

                            return SingleSelectionWidget(
                                image: AppImages.paypal,
                                showDivider: false,
                                showPadding: false,
                                model:viewModel.arrOfPayment[index],
                                onTap: () {

                                  if(viewModel.arrOfPayment[index].isSelected!.value){
                                   // viewModel.arrOfPayment[index].isSelected!.value = false;
                                  }else{
                                    viewModel.arrOfPayment[index].isSelected!.value = true;
                                  }
                                });

                          },),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: AppDimen.verticalSpacing.h),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

              child: CustomButton(
                label: 'proceed_to_payment'.tr,
                textColor: AppColors.white,
                controller: viewModel.btnController,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  viewModel.onDoneTap();
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}
