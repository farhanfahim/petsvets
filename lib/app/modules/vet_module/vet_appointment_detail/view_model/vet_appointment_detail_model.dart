import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
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
import '../../../../components/widgets/custom_textfield.dart';
import '../../../dashboard/view_model/dashboard_view_model.dart';

class VetAppointmentDetailViewModel extends GetxController {
  var data = Get.arguments;
  final DashboardViewModel dashboardViewModel = Get.find();
  RxList<String> arrOfOption = List<String>.empty().obs;
  RxList<String> arrOfMoreOption = List<String>.empty().obs;
  StatusType? type;
  RxBool showPrescribeBtn = false.obs;
  var formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController(text: "");
  FocusNode reasonNode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    if (data != null ) {
      print(data[ArgumentConstants.type]);
      type = data[ArgumentConstants.type];
    }

    arrOfOption.add("report_user".tr);

    arrOfMoreOption.add("False Information");
    arrOfMoreOption.add("Spam");
    arrOfMoreOption.add("Harassment");
    arrOfMoreOption.add("Other");


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
          widget: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
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
                padding: const EdgeInsets.all(AppDimen.allPadding),
                child: MyText(text: "report_desc".tr,
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,),
              ),

              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
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
                      padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
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
                    hintText: "reason".tr,
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.name,
                    limit: Constants.descriptionLimit,
                    validator: (value) {
                      return HelperFunction.validateValue(value!,"reason".tr);
                    },
                  ),),
                const SizedBox(height: AppDimen.pagesVerticalPadding,)
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
