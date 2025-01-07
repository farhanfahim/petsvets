import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/app_font_size.dart';
import '../../../../../../utils/argument_constants.dart';
import '../../../../../../utils/bottom_sheet_service.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../data/models/appointment_model.dart';

class AppointmentDetailViewModel extends GetxController {
  var data = Get.arguments;

  RxList<String> arrOfOption = List<String>.empty().obs;
  RxList<String> arrOfMoreOption = List<String>.empty().obs;
  RxList<PetTypeModel> arrOfPrescription = List<PetTypeModel>.empty().obs;
  Rx<PetTypeModel>? defaultPrescriptionMode;
  Rx<PetTypeModel>? selectedPrescriptionMode;
  StatusType? type;
  AppointmentData? appointmentData;
  RxBool showChatBtn = false.obs;
  var formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController(text: "");
  FocusNode reasonNode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    if (data != null ) {
      appointmentData = data[ArgumentConstants.type];
      if(appointmentData!.type != StatusType.completed){
        type = StatusType.confirmed;
        //type = appointmentData!.type;
      }else{
        type = appointmentData!.type;
      }

    }

    arrOfOption.add("report_doctor".tr);
    arrOfMoreOption.add("False Information");
    arrOfMoreOption.add("Spam");
    arrOfMoreOption.add("Harassment");
    arrOfMoreOption.add("Other");

    arrOfPrescription.add(PetTypeModel(title: "pick_up_from_pharmacy".tr,breed: "".obs,isSelected: true.obs));
    arrOfPrescription.add(PetTypeModel(title: "deliver_it_to_my_doorstep".tr,breed: "".obs,isSelected: false.obs));
    arrOfPrescription.add(PetTypeModel(title: "i_have_direct_access_to_pharmacy".tr,breed: "".obs,isSelected: false.obs));
    defaultPrescriptionMode = arrOfPrescription[0].obs;
    selectedPrescriptionMode = arrOfPrescription[0].obs;

  }

  onTapPrescription(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showLeading: true,
          showLeadingIcon: true,
          showBottomBtn: false,
          centerTitle: true,
          titleSize: AppFontSize.small,
          leadingText: "cancel".tr,
          actionText: "done".tr,
          actionColor: AppColors.red,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "prescription_mode_".tr,

          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                child: MyText(
                  text: "select_mode_of_pharmacy".tr,
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: arrOfPrescription.length,
                itemBuilder: (BuildContext context, int subIndex) {
                  return GestureDetector(
                    onTap: (){
                      for(var item in arrOfPrescription){
                        item.isSelected!.value = false;
                      }
                      if(!arrOfPrescription[subIndex].isSelected!.value){
                         arrOfPrescription[subIndex].isSelected!.value = true;
                      }

                      defaultPrescriptionMode!.value = arrOfPrescription[subIndex];
                      arrOfPrescription.refresh();

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: 5),
                      child: Row(
                        children: [
                          CommonImageView(
                            svgPath: arrOfPrescription[subIndex].isSelected!.value?AppImages.radioSelected:AppImages.radioUnSelected,
                            width: 5.w,
                          ),
                          const SizedBox(width: AppDimen.contentPadding,),
                          MyText(
                            text: arrOfPrescription[subIndex].title!,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),),
              const SizedBox(height: AppDimen.pagesVerticalPaddingNew,),
            ],
          ),
          leadingTap: (){
            Get.back();
          },
          actionTap: () {
            selectedPrescriptionMode!.value = defaultPrescriptionMode!.value;
            Get.back();
          },
        ));
  }

  onTapReport(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "select_action".tr,
          widget: Padding(
            padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPadding),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: arrOfOption.length,
              itemBuilder: (BuildContext context, int subIndex) {
                return GestureDetector(
                  onTap: (){
                    Get.back();
                    moreReportOption();
                  },
                  child: Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                    child: MyText(
                      text: arrOfOption[subIndex],
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  moreReportOption(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "report".tr,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:  AppDimen.allPadding,right:  AppDimen.allPadding,top:  AppDimen.allPadding,bottom: 5),
                child: MyText(text: "report_desc".tr,
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: arrOfMoreOption.length,
                  itemBuilder: (BuildContext context, int subIndex) {
                    return GestureDetector(
                      onTap: (){
                        if(arrOfMoreOption[subIndex] == "Other"){
                          Get.back();
                          openOtherBottomSheet();
                        }else{
                          Get.back();
                          Get.back();
                          Util.showAlert(title: "your_report");
                        }

                      },
                      child: Container(
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: 5),
                        child: MyText(
                          text: arrOfMoreOption[subIndex],
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  openOtherBottomSheet(){
    BottomSheetService.showGenericBottomSheet(
        child:  CustomBottomSheet(

          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "done".tr,
          actionColor: AppColors.red,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "report".tr,

          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                  child: MyText(
                    text: "reason".tr,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),

                Form(
                  key: formKey,
                  child: CustomTextField(
                    controller: reasonController,
                    focusNode: reasonNode,
                    hintText: "enter_text_here".tr,
                    maxLines: 4,
                    minLines: 4,
                    keyboardType: TextInputType.name,
                    limit: Constants.descriptionLimit,
                    validator: (value) {
                      return HelperFunction.validateValue(value!,"reason".tr);
                    },
                  ),),
                const SizedBox(height: AppDimen.pagesVerticalPadding,),
              ],
            ),
          ),
          actionTap: (){
            if (formKey.currentState?.validate() == true) {
              Get.back();
              Get.back();
              Util.showAlert(title: "your_report");
            } else {
              print('not validated');
            }

          },
        )
    );
  }

}
