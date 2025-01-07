import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/enums/page_type.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/app/modules/pet_module/appointment_detail/widgets/appointment_prescription_widget.dart';
import 'package:petsvet_connect/app/modules/pet_module/appointment_detail/widgets/appointment_reason_widget.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../firestore/chat_constants.dart';
import '../view_model/appointment_detail_model.dart';
import '../widgets/appointment_cancelled_widget.dart';
import '../widgets/appointment_doctor_info_widget.dart';
import '../widgets/appointment_duration_widget.dart';
import '../widgets/appointment_info_widget.dart';
import '../widgets/appointment_payment_widget.dart';

class AppointmentDetailView extends StatelessWidget {
  final AppointmentDetailViewModel viewModel =
      Get.put(AppointmentDetailViewModel());

  AppointmentDetailView({super.key});

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
                    AppointmentInfoWidget(
                      model: viewModel.appointmentData!,
                    ),
                    AppointmentDurationWidget(duration:viewModel.appointmentData!.duration!),
                    AppointmentDoctorInfoWidget(model:viewModel.appointmentData!.vet,
                      onTap: () {
                       Get.toNamed(Routes.VET_PROFILE,arguments: {"id":viewModel.appointmentData!.vetId!});
                      },
                    ),
                    Visibility(
                        visible: viewModel.type! == StatusType.completed,
                        child: AppointmentReasonWidget(model:viewModel.appointmentData)),
                    Visibility(
                        visible: viewModel.type! == StatusType.completed,
                        child: Obx(() => AppointmentPrescriptionInfoWidget(title:viewModel.selectedPrescriptionMode!.value.title,onTap: (){
                          viewModel.onTapPrescription();
                        },))),
                    Visibility(
                        visible: viewModel.type! == StatusType.cancelled,
                        child: AppointmentCancelledWidget(model:viewModel.appointmentData)),
                    AppointmentPaymentWidget(
                      model: viewModel.appointmentData!,
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
                        Get.toNamed(Routes.CANCEL_APPOINTMENT,arguments: {ArgumentConstants.type:viewModel.appointmentData!});
                      },
                    );
                  },
                ),
              ),
            ),
            Obx(() => Visibility(
              visible: viewModel.showChatBtn.value,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'chat_now'.tr,
                  color: AppColors.red,
                  prefix: const CommonImageView(
                    svgPath: AppImages.chat,
                    color: AppColors.white,
                  ),
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Map<String, dynamic> map = {
                      ChatConstants.documentId: viewModel.appointmentData!.id,
                      ChatConstants.userId: viewModel.appointmentData!.vetId,
                      ChatConstants.threadName: viewModel.appointmentData!.vet!.fullName,
                      ChatConstants.fromCreation: true};

                    Get.toNamed(Routes.CHAT_ROOM,arguments: map);
                  },
                ),
              ),
            ),),

            Visibility(
              visible: viewModel.type! == StatusType.completed && !viewModel.showChatBtn.value,
              child: Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'follow_up'.tr,
                  color: AppColors.red,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Get.toNamed(Routes.SCHEDULE_APPOINTMENT,arguments: {
                      ArgumentConstants.pageType:PageType.detail,
                      ArgumentConstants.id:viewModel.appointmentData!.vetId!
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: viewModel.type! == StatusType.confirmed,
              child: Obx(() => Visibility(
                visible: !viewModel.showChatBtn.value,
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
                                Get.toNamed(Routes.CANCEL_APPOINTMENT,arguments: {ArgumentConstants.type:viewModel.appointmentData});
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
                                              viewModel.showChatBtn.value = true;
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
                                              viewModel.showChatBtn.value = true;
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
          ],
        ));
  }
}
