import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/schedule_appointment/widgets/date_widget.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../utils/helper_functions.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../components/widgets/multi_image_view.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../repository/schedule_repository.dart';
import '../view_model/schedule_appointment_view_model.dart';
import '../widgets/appointment_general_widget.dart';
import '../widgets/duration_widget.dart';
import '../widgets/emergency_tile.dart';
import '../widgets/slot_widget.dart';

class ScheduleAppointmentView extends StatelessWidget {

  ScheduleAppointmentViewModel viewModel = Get.put(ScheduleAppointmentViewModel(repository: Get.find<ScheduleRepository>()));
  ScheduleAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        titleColor: AppColors.blackColor,
        appBarBackgroundColor: AppColors.white,
        backgroundColor: AppColors.white,
        backIconColor: AppColors.blackColor,
        screenName: viewModel.data[ArgumentConstants.pageType] ==PageType.profile?"schedule_appointment".tr:"schedule_follow_up".tr,
        centerTitle: true,
        horizontalPadding: false,
        verticalPadding: false,
        resizeToAvoidBottomInset: true,
        hasBackButton: true.obs,
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: viewModel.scrollController,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: AppDimen.pagesVerticalPadding,),
                    Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimen.pagesHorizontalPadding,
                          vertical: AppDimen.pagesVerticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: "select_pet_".tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: 14,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => CustomTextField(
                              controller: viewModel.petController.value,
                              hintText: "select_pet_".tr,
                              label: "pet".tr,
                              readOnly: true,
                              onTap: () {
                                viewModel.onPetSheet();
                              },
                              validator: (value) {
                                return HelperFunction.validateValue(value!,"pet".tr);
                              },
                              icon: AppImages.arrowDown,
                              keyboardType: TextInputType.name,
                              limit: Constants.fullNameLimit,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
                    ),
                    Visibility(
                      visible: viewModel.data[ArgumentConstants.pageType] ==PageType.profile,
                      child: EmergencyTile(
                        controller: viewModel.controller,
                        title: "emergency_case".tr,
                      ),
                    ),
                    Visibility(
                      visible: viewModel.data[ArgumentConstants.pageType] ==PageType.profile,
                      child: const SizedBox(
                        height: AppDimen.pagesVerticalPaddingNew,
                      ),
                    ),
                    AppointmentGeneralWidget(
                      title: viewModel.data[ArgumentConstants.pageType] ==PageType.profile?"select_date_for_appointment".tr:"select_date_for_follow_up".tr,
                      widget: GestureDetector(
                        onTap: (){
                          viewModel.onTapCalender();
                        },
                        child: const CommonImageView(
                          svgPath: AppImages.calenderMini,
                        ),
                      ),
                      mainWidget: Container(
                        child: Column(
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

                                  print( viewModel.today.value);
                                  print( viewModel.arrOfDate[index].date);

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
                    ),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
                    ),
                    AppointmentGeneralWidget(
                      title: "select_duration".tr,
                      isMandatory: true,
                      mainWidget: Container(

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimen.verticalSpacing.h,),
                            SizedBox(
                              height: 60,
                              child: Obx(() => viewModel.isDataLoading.value?const Row(
                                children: [

                                  SizedBox(width: 15,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                  SizedBox(width: 10,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                  SizedBox(width: 10,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                ],
                              ):viewModel.arrOfScheduleSlotTimes.isNotEmpty?ListView.builder(
                                scrollDirection:Axis.horizontal,
                                itemCount:viewModel.arrOfScheduleSlotTimes.length,
                                itemBuilder: (BuildContext context, int index) {

                                  return Padding(
                                    padding: EdgeInsets.only(right: index ==viewModel.arrOfScheduleSlotTimes.length-1?5:0,left: index ==0?AppDimen.pagesHorizontalPadding:0),
                                    child: DurationWidget(
                                      onTap: (){
                                        viewModel.onDurationTap(index);
                                      },model: viewModel.arrOfScheduleSlotTimes[index].slot!,),
                                  );

                                },):const MyText(text: "No Duration Found.",),)
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
                    ),
                    AppointmentGeneralWidget(
                      title: "select_slots".tr,
                      isMandatory: true,
                      mainWidget: Padding(

                        padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimen.verticalSpacing.h,),
                            Obx(() =>  viewModel.isDataLoading.value?const Row(
                              children: [
 
                                Skeleton(width: 100,height: 30,switchColor: true,),
                                SizedBox(width: 10,),
                                Skeleton(width: 100,height: 30,switchColor: true,),
                                SizedBox(width: 10,),
                                Skeleton(width: 100,height: 30,switchColor: true,),
                              ],
                            ):viewModel.arrOfTimeSlotModel.isNotEmpty?GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:  AppDimen.gridCount,
                                mainAxisSpacing: AppDimen.gridSpacing,
                                crossAxisSpacing:AppDimen.gridSpacing,
                                mainAxisExtent:40,

                              ),

                              itemCount: viewModel.arrOfTimeSlotModel.length,
                              itemBuilder: (context, index) {
                                return SlotWidget(model:viewModel.arrOfTimeSlotModel[index], onTap: (){
                                  viewModel.onSlotTap(index);
                                });
                              },
                            ):const MyText(text: "No Slots Found.",)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
                    ),
                    Visibility(
                      visible: viewModel.data[ArgumentConstants.pageType] ==PageType.profile,
                      child: AppointmentGeneralWidget(
                        title: "add_medical_record".tr,
                        isMandatory: true,
                        widget: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.MEDICAL_RECORD,arguments: {
                              ArgumentConstants.pageType:PageType.scheduleAppointment
                            })!.then((value) {
                              viewModel.arrOfImage.value = value;
                              viewModel.arrOfImage.refresh();
                            });
                          },
                          child: Row(
                            children: [
                              CommonImageView(
                                svgPath: AppImages.imgPlus,
                                width: 3.h,
                              ),
                              MyText(
                                text: "add_new".tr,
                                color: AppColors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                        mainWidget: Container(

                          padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MultiImageView(showDivider:false,showPicker:false,bottomPadding:20.0,arrOfImage:  viewModel.arrOfImage,coverTitle: "upload_record".tr),

                            ],
                          ),
                        ),

                      ),
                    ),
                    Visibility(
                      visible: viewModel.data[ArgumentConstants.pageType] ==PageType.profile,
                      child: const SizedBox(
                        height: AppDimen.pagesVerticalPaddingNew,
                      ),
                    ),
                    Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                      child: CustomTextField(
                        controller: viewModel.reasonController.value,
                        focusNode: viewModel.reasonNode,
                        hintText: "enter_text_here".tr,
                        label: "reason".tr,
                        minLines: 4,
                        maxLines: 4,
                        onTap: (){
                          Future.delayed(const Duration(milliseconds: 800), () {
                            viewModel.scrollController.animateTo(
                              viewModel.scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          });
                        },
                        validator: (value) {
                          return HelperFunction.validateValue(value!,"reason".tr);
                        },
                        keyboardType: TextInputType.text,
                        limit: Constants.descriptionLimit,
                      ),
                    ),
                    const SizedBox(
                      height: AppDimen.pagesVerticalPaddingNew,
                    ),
                  ]),
                ),
              ),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),
                child: CustomButton(
                  label: 'proceed_to_payment'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    Util.hideKeyBoard(context);
                    viewModel.onTapProceed();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
