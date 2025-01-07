import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/date_time_util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/radiobox.dart';
import '../../../../components/widgets/text_field_label.dart';
import '../../../../repository/slot_repository.dart';
import '../../../pet_module/schedule_appointment/widgets/appointment_general_widget.dart';
import '../../../pet_module/schedule_appointment/widgets/date_widget.dart';
import '../../../pet_module/schedule_appointment/widgets/slot_widget.dart';
import '../view_model/manage_time_slot_view_model.dart';

class ManageTimeSlotView extends StatelessWidget {

  ManageTimeSlotViewModel viewModel = Get.put(ManageTimeSlotViewModel(repository: Get.find<SlotRepository>()));

  ManageTimeSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        titleColor: AppColors.blackColor,
        backIconColor: AppColors.blackColor,
        backgroundColor: AppColors.backgroundColor,
        screenName: "manage_time_slots".tr,
        centerTitle: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
          children: [

            SizedBox(
            height: 100.h,
              child: SingleChildScrollView(
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
                          TextFieldLabel(isBold:true,label: "select_type".tr,mandatory: false,),
                          const SizedBox(height: AppDimen.pagesVerticalPadding),
                          Column(
                            children: [
                             Obx(() =>  RadioBoxField(
                               initialValue:  viewModel.fullTime.value,
                               mandatory: true,
                               simpleTitle: "full_time_available".tr,
                               callback: (val) {
                                 viewModel.specificTime.value = false;
                                 viewModel.fullTime.value = true;
                                 viewModel.getScheduledSlots(viewModel.selectedDate.value);
                               },
                             ),),
                              const SizedBox(height: AppDimen.pagesVerticalPadding),
                             Obx(() =>  RadioBoxField(
                               initialValue: viewModel.specificTime.value,
                               mandatory: true,
                               simpleTitle: "choose_specific_time".tr,
                               callback: (val) {
                                 viewModel.fullTime.value = false;
                                 viewModel.specificTime.value = true;
                                 viewModel.getScheduledSlots(viewModel.selectedDate.value);
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

                        AppointmentGeneralWidget(
                          title: "available_slots".tr,
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

                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),

                        Obx(() => Visibility(
                            visible: viewModel.fullTime.isFalse ,
                            child: viewModel.isDataLoading.value?const Row(
                          children: [

                            SizedBox(width: 15,),
                            Skeleton(width: 100,height: 30,switchColor: true,),
                            SizedBox(width: 10,),
                            Skeleton(width: 100,height: 30,switchColor: true,),
                            SizedBox(width: 10,),
                            Skeleton(width: 100,height: 30,switchColor: true,),
                          ],
                        ):ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.arrOfTimeSlot.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => Visibility(
                                visible: viewModel.arrOfTimeSlot[index].timeSlots!.isNotEmpty,
                                child: AppointmentGeneralWidget(
                                  title: viewModel.arrOfTimeSlot[index].duration,
                                  isBold:true,
                                  mainWidget:  Padding(
                                    padding: const EdgeInsets.only(top: AppDimen.pagesVerticalPadding),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:  AppDimen.gridCount,
                                        mainAxisSpacing: AppDimen.gridSpacing,
                                        crossAxisSpacing:AppDimen.gridSpacing,
                                        mainAxisExtent:40,

                                      ),

                                      itemCount: viewModel.arrOfTimeSlot[index].timeSlots!.length,
                                      itemBuilder: (context, subIndex) {
                                        return SlotWidget(model:viewModel.arrOfTimeSlot[index].timeSlots![subIndex], onTap: (){
                                          viewModel.onTapSlot(index,subIndex);
                                        });
                                      },
                                    ),
                                  ),
                                )));
                          },
                        )),),

                        Obx(() => Visibility(
                          visible: viewModel.fullTime.isTrue ,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Obx(() => viewModel.fullTime.isTrue && viewModel.isDataLoading.value?const Row(
                                children: [

                                  SizedBox(width: 15,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                  SizedBox(width: 10,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                  SizedBox(width: 10,),
                                  Skeleton(width: 100,height: 30,switchColor: true,),
                                ],
                              ):Visibility(
                                visible:  !viewModel.isDurationsEmpty.value,
                                child: AppointmentGeneralWidget(
                                  title: "duration".tr,
                                  isBold:true,
                                  mainWidget: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: AppDimen.pagesVerticalPadding),
                                      SizedBox(
                                          height: 40,
                                          child: Obx(() => ListView.builder(
                                            scrollDirection:Axis.horizontal,
                                            itemCount:viewModel.durations.length,
                                            itemBuilder: (BuildContext context, int index) {

                                              return GestureDetector(
                                                onTap:(){
                                                  viewModel.onTapDuration(index);
                                                },child: Visibility(
                                                visible: viewModel.durations[index].isSelected!.value,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      border: Border.all(color: AppColors.gray600.withOpacity(0.3)),
                                                      borderRadius: const BorderRadius.all(Radius.circular(AppDimen.dateBorderRadius),
                                                      ),
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding, vertical:AppDimen.contentPadding),
                                                    margin: const EdgeInsets.only(right:AppDimen.contentSpacing),
                                                    child: MyText(
                                                      text: "${viewModel.durations[index].duration!} mins",
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColors.gray600,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              );

                                            },),)
                                      ),
                                    ],
                                  ),
                                ),
                              ),)



                            ],
                          ),
                        )),

                        const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
                      ],
                    ),



                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: (){
                  viewModel.onTapAddSlot();
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.all(Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: AppDimen.horizontalSpacing,),
                      const CommonImageView(
                        svgPath: AppImages.imgPlus,
                        color: AppColors.white,
                        width: 28,
                      ),
                      const SizedBox(width: AppDimen.horizontalSpacing,),
                      MyText(text: "add_slot".tr,color: AppColors.white,fontWeight: FontWeight.w700,),
                      const SizedBox(width: AppDimen.pagesHorizontalPadding,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
