import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_dialog.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../firestore/chat_constants.dart';
import '../view_model/vet_appointment_detail_model.dart';
import '../widgets/alert_widget.dart';
import '../widgets/appointment_cancelled_widget.dart';
import '../widgets/appointment_duration_widget.dart';
import '../widgets/appointment_info_widget.dart';
import '../widgets/appointment_medical_record_widget.dart';
import '../widgets/appointment_payment_widget.dart';
import '../widgets/appointment_pet_info_widget.dart';
import '../widgets/appointment_reason_widget.dart';

class VetAppointmentDetailView extends StatelessWidget {
  final VetAppointmentDetailViewModel viewModel =
      Get.put(VetAppointmentDetailViewModel());

  VetAppointmentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        titleColor: AppColors.blackColor,
        backIconColor: AppColors.blackColor,
        backgroundColor: AppColors.white,
        screenName: "appointment_details".tr,
        centerTitle: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        actions: [
          GestureDetector(
            onTap: (){
              viewModel.onTapReport();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: AppDimen.pagesHorizontalPadding),
              child: CommonImageView(
                svgPath: AppImages.dotMenu,
              ),
            ),
          )
        ],
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                    Visibility(
                        visible: viewModel.type! != StatusType.completed,
                        child: AlertWidget(image: AppImages.alertRed,title: "need_urgent".tr,color: AppColors.red,)),
                    Visibility(
                        visible: viewModel.type! != StatusType.completed,
                        child: AlertWidget(image: AppImages.info,title: "have_access".tr,color: AppColors.primaryColor,)),
                    AppointmentInfoWidget(
                      type: viewModel.type!,
                    ),
                    const AppointmentDurationWidget(),
                    AppointmentPetInfoWidget(
                      onTap: () {
                        //Get.toNamed(Routes.VET_PROFILE);
                      },
                    ),
                    Visibility(
                        visible: viewModel.type! != StatusType.cancelled,
                        child: const AppointmentReasonWidget()),
                    Visibility(
                        visible: viewModel.type! == StatusType.cancelled,
                        child: const AppointmentCancelledWidget()),
                    Visibility(
                        visible: viewModel.type! != StatusType.cancelled && viewModel.type! != StatusType.completed,
                        child: const AppointmentMedicalRecordWidget()),

                    AppointmentPaymentWidget(
                      type: viewModel.type!,
                    ),
                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                  ],
                ),
              ),
            ),

            Visibility(
              visible: viewModel.type! == StatusType.pending,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'reject'.tr,
                        borderColor: AppColors.red,
                        color: AppColors.white,
                        textColor: AppColors.red,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          BottomSheetService.showConfirmationDialog(
                            title: "reject",
                            content: "are_you_sure_you_want_to_reject",
                            leftButtonText: "cancel",
                            rightButtonText: "reject",
                            onAgree: () async {
                              Get.back();
                              Get.back();
                              Util.showAlert(title: "your_appointment_has_been_rejected");
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppDimen.allPadding,),
                    Expanded(
                      child: CustomButton(
                        label: 'accept'.tr,
                        borderColor: AppColors.red,
                        color: AppColors.red,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ct) {
                                return CustomDialogue(
                                  image: AppImages.alertInfo,
                                  dialogueBoxHeading: "alert".tr,
                                  dialogueBoxText: "you_have_already_schedule".tr,
                                  actionOnNo: () {
                                    Get.back();
                                  },
                                  actionOnYes: () {
                                    Get.back();
                                    Get.back();
                                    Util.showAlert(title: "your_appointment_has_benn_accepted");
                                  },
                                  noText: "cancel".tr,
                                  yesText: "yes_accept".tr,
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: viewModel.type! == StatusType.confirmed,
              child: Obx(() => Visibility(
                visible: !viewModel.showPrescribeBtn.value,
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          label: 'cancel_appointment'.tr,
                          borderColor: AppColors.red,
                          color: AppColors.white,
                          textColor: AppColors.red,
                          fontWeight: FontWeight.w600,
                          onPressed: () {

                            BottomSheetService.showConfirmationDialog(
                              title: "cancel_appointment",
                              content: "are_you_sure_want_to_cancel_Appointment",
                              leftButtonText: "no",
                              rightButtonText: "yes_cancel",
                              onAgree: () async {

                                Get.back();
                                Get.back();
                                Util.showAlert(title: "your_appointment_has_benn_cancelled");
                              },
                            );


                          },
                        ),
                      ),
                      const SizedBox(width: AppDimen.allPadding,),
                      Expanded(
                        child: CustomButton(
                          label: 'start_session'.tr,
                          borderColor: AppColors.red,
                          color: AppColors.red,
                          textColor: AppColors.white,
                          fontWeight: FontWeight.w600,
                          onPressed: () {
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
                                  title: "select_action".tr,
                                  widget:Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: (){
                                            Get.back();
                                            Get.toNamed(Routes.VIDEO_CALL,
                                                arguments: {ArgumentConstants.pageType:PageType.video})!.then((value) {
                                              viewModel.showPrescribeBtn.value = true;
                                            });
                                          },
                                          child: Container(
                                            color: AppColors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const CommonImageView(
                                                  svgPath: AppImages.video,
                                                ),
                                                const SizedBox(height: 5,),
                                                MyText(text: "video_call".tr,color: AppColors.black,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: (){
                                            Get.back();
                                            Get.toNamed(Routes.VIDEO_CALL,
                                                arguments: {ArgumentConstants.pageType:PageType.voice})!.then((value) {
                                              viewModel.showPrescribeBtn.value = true;
                                            });
                                          },
                                          child: Container(
                                            color: AppColors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const CommonImageView(
                                                  svgPath: AppImages.call,
                                                  width: 24,
                                                ),
                                                const SizedBox(height: 5,),
                                                MyText(text: "voice_call".tr,color: AppColors.black,)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  actionTap: (){
                                    Get.back();
                                  },
                                )
                            );

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),)
            ),
            Visibility(
              visible: viewModel.type! == StatusType.completed,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'follow_up'.tr,
                  borderColor: AppColors.red,
                  color: AppColors.red,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {

                    Map<String, dynamic> map = {
                      //ChatConstants.documentId: viewModel.appointmentData!.id,
                      //ChatConstants.userId: viewModel.appointmentData!.vetId,
                      //ChatConstants.threadName: viewModel.appointmentData!.vet!.fullName,
                      ChatConstants.fromCreation: true};

                    Get.toNamed(Routes.CHAT_ROOM,arguments: map);
                  },
                ),
              ),
            ),
            Obx(() => Visibility(
              visible: viewModel.showPrescribeBtn.value,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'prescribe_medicine'.tr,
                  borderColor: AppColors.red,
                  color: AppColors.red,
                  prefix: const CommonImageView(
                    svgPath: AppImages.prescribe,
                  ),
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Get.toNamed(Routes.PRESCRIBE_MEDICINE);
                  },
                ),
              ),
            ),)
          ],
        ));
  }
}
