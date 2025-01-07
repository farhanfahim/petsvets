import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/radiobox.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../data/models/select_time_model.dart';
import '../../../../repository/slot_repository.dart';
import '../../../pet_module/schedule_appointment/widgets/appointment_general_widget.dart';
import '../../../pet_module/schedule_appointment/widgets/date_widget.dart';
import '../view_model/add_time_slot_view_model.dart';

class AddTimeSlotView extends StatelessWidget {

  AddTimeSlotViewModel viewModel = Get.put(AddTimeSlotViewModel(repository: Get.find<SlotRepository>()));

  AddTimeSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        titleColor: AppColors.blackColor,
        backIconColor: AppColors.blackColor,
        backgroundColor: AppColors.white,
        screenName: "add_slot".tr,
        centerTitle: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        resizeToAvoidBottomInset: true,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(

                controller: viewModel.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                    Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldLabel(isBold:true,label: "availability".tr,mandatory: false,),
                          const SizedBox(height: AppDimen.pagesVerticalPadding),
                          Column(
                            children: [
                              Obx(() =>  RadioBoxField(
                                initialValue:  viewModel.manageTimeSlotViewModel.fullTime.value,
                                mandatory: true,
                                simpleTitle: "full_time_available".tr,
                                callback: (val) {
                                  viewModel.manageTimeSlotViewModel.specificTime.value = false;
                                  viewModel.manageTimeSlotViewModel.fullTime.value = true;
                                },
                              ),),
                              const SizedBox(height: AppDimen.pagesVerticalPadding),
                              Obx(() =>  RadioBoxField(
                                initialValue: viewModel.manageTimeSlotViewModel.specificTime.value,
                                mandatory: true,
                                simpleTitle: "choose_specific_time".tr,
                                callback: (val) {
                                  viewModel.manageTimeSlotViewModel.fullTime.value = false;
                                  viewModel.manageTimeSlotViewModel.specificTime.value = true;
                                },
                              ),)
                            ],
                          ),

                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: AppDimen.pagesVerticalPaddingNew,
                        ),
                        AppointmentGeneralWidget(
                          title: "select_date".tr,
                          isBold:true,
                          widget: GestureDetector(
                            onTap: (){
                              viewModel.onTapCalender();
                            },
                            child: const CommonImageView(
                              svgPath: AppImages.calenderMini,
                            ),
                          ),
                          mainWidget: Column(
                            children: [
                              SizedBox(height: AppDimen.verticalSpacing.h,),
                              SizedBox(
                                  height: 60,
                                  child: Obx(() => ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection:Axis.horizontal,
                                    itemCount:viewModel.arrOfDate.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      DateFormat dateFormatter = DateFormat(DateTimeUtil.dateTimeFormat4);
                                      List<String> splittedDate = viewModel.today.toString().split(' ');
                                      viewModel.today.value = dateFormatter.parse(splittedDate.first);

                                      return Padding(
                                        padding: EdgeInsets.only(right: index ==viewModel.arrOfDate.length-1?5:0,left: index ==0?AppDimen.pagesHorizontalPadding:0),
                                        child: DateWidget(
                                          isFirst: index==0 && viewModel.arrOfDate[index].date == viewModel.today.value?true:false,
                                          onTap: (){
                                            viewModel.onDateTap(index);
                                          },model: viewModel.arrOfDate[index],),
                                      );

                                    },),)
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: AppDimen.pagesVerticalPaddingNew,
                        ),
                        AppointmentGeneralWidget(
                          title: "select_duration".tr,
                          isBold:true,
                          isMandatory: true,
                          mainWidget: Obx(() => viewModel.manageTimeSlotViewModel.fullTime.isTrue
                              ?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppDimen.pagesVerticalPadding),
                              SizedBox(
                                  height: 40,
                                  child: Obx(() => ListView.builder(
                                    scrollDirection:Axis.horizontal,
                                    itemCount:viewModel.manageTimeSlotViewModel.durations.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      DateFormat dateFormatter = DateFormat(DateTimeUtil.dateTimeFormat4);
                                      List<String> splittedDate = viewModel.today.toString().split(' ');
                                      viewModel.today.value = dateFormatter.parse(splittedDate.first);

                                      return GestureDetector(
                                        onTap:(){
                                          viewModel.onSlotTap(index);
                                        },child: Padding(
                                        padding: EdgeInsets.only(right: index ==viewModel.manageTimeSlotViewModel.durations.length-1?5:0,left: index ==0?AppDimen.pagesHorizontalPadding:0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: viewModel.manageTimeSlotViewModel.durations[index].isSelected!.value?AppColors.lightBlue:AppColors.white,
                                            border: Border.all(color: viewModel.manageTimeSlotViewModel.durations[index].isSelected!.value?AppColors.primaryColor:AppColors.gray600.withOpacity(0.3)),
                                            borderRadius: const BorderRadius.all(Radius.circular(AppDimen.dateBorderRadius),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding, vertical:AppDimen.contentPadding),
                                          margin: const EdgeInsets.only(right:AppDimen.contentSpacing),
                                          child: MyText(
                                            text: "${viewModel.manageTimeSlotViewModel.durations[index].duration} mins",

                                            fontWeight: viewModel.manageTimeSlotViewModel.durations[index].isSelected!.value?FontWeight.w600:FontWeight.w400,
                                            color: viewModel.manageTimeSlotViewModel.durations[index].isSelected!.value?AppColors.primaryColor:AppColors.gray600,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      );

                                    },),)
                              ),
                            ],
                          )
                              :Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppDimen.pagesVerticalPadding),
                              SizedBox(
                                  height: 40,
                                  child: Obx(() => viewModel.isDataLoading.value?Container():ListView.builder(
                                    scrollDirection:Axis.horizontal,
                                    itemCount:viewModel.arrOfDuration.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      DateFormat dateFormatter = DateFormat(DateTimeUtil.dateTimeFormat4);
                                      List<String> splittedDate = viewModel.today.toString().split(' ');
                                      viewModel.today.value = dateFormatter.parse(splittedDate.first);

                                      return GestureDetector(
                                        onTap:(){
                                          viewModel.onSlotTap(index);
                                        },child: Padding(
                                        padding: EdgeInsets.only(right: index ==viewModel.arrOfDuration.length-1?5:0,left: index ==0?AppDimen.pagesHorizontalPadding:0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: viewModel.arrOfDuration[index].isSelected!.value?AppColors.lightBlue:AppColors.white,
                                            border: Border.all(color: viewModel.arrOfDuration[index].isSelected!.value?AppColors.primaryColor:AppColors.gray600.withOpacity(0.3)),
                                            borderRadius: const BorderRadius.all(Radius.circular(AppDimen.dateBorderRadius),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding, vertical:AppDimen.contentPadding),
                                          margin: const EdgeInsets.only(right:AppDimen.contentSpacing),
                                          child: MyText(
                                            text: "${viewModel.arrOfDuration[index].duration!} mins",

                                            fontWeight: viewModel.arrOfDuration[index].isSelected!.value?FontWeight.w600:FontWeight.w400,
                                            color: viewModel.arrOfDuration[index].isSelected!.value?AppColors.primaryColor:AppColors.gray600,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      );

                                    },),)
                              ),
                            ],
                          ),)
                        ),

                        const SizedBox(
                          height: AppDimen.pagesVerticalPaddingNew,
                        ),

                      ],
                    ),

                    Obx(() => Visibility(
                      visible: viewModel.manageTimeSlotViewModel.specificTime.isTrue,
                      child: Container(
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            TextFieldLabel(isBold:true,label: "select_time".tr,mandatory: true,),


                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.arrOfTimeSlot.length,
                              itemBuilder: (BuildContext context, int subIndex) {
                                return Padding(

                                  padding: const EdgeInsets.only(top: AppDimen.pagesVerticalPaddingNew,),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: viewModel.arrOfTimeSlot[subIndex].startTimeController,
                                          hintText: "select_start_time".tr,
                                          label: "start_time".tr,
                                          keyboardType: TextInputType.text,
                                          limit: Constants.stateNumber,
                                          isMandatory: false,
                                          readOnly: true,
                                          onTap: (){
                                            viewModel.onTapStartTime(subIndex);
                                          },
                                          icon: AppImages.clock,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: viewModel.arrOfTimeSlot[subIndex].endTimeController,
                                          hintText: "select_end_time".tr,
                                          label: "end_time".tr,
                                          keyboardType: TextInputType.text,
                                          limit: Constants.stateNumber,
                                          isMandatory: false,
                                          readOnly: true,
                                          onTap: (){
                                            viewModel.onTapEndTime(subIndex);
                                          },
                                          icon: AppImages.clock,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            GestureDetector(
                              onTap: () {
                                viewModel.arrOfTimeSlot.add(SelectTimeModel(startTimeController: TextEditingController(),endTimeController: TextEditingController()));
                                Future.delayed(const Duration(milliseconds: 300), () {
                                  viewModel.scrollController.animateTo(
                                    viewModel.scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                });
                              },
                              child: Container(
                                width: double.maxFinite,

                                padding: const EdgeInsets.only(top: AppDimen.pagesVerticalPadding,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))

                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
            Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

              child: CustomButton(
                label: 'save'.tr,
                borderColor: AppColors.red,
                color: AppColors.red,
                controller: viewModel.btnController,
                textColor: AppColors.white,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  viewModel.onTapSave();
                },
              ),
            ),
          ],
        ));
  }
}
