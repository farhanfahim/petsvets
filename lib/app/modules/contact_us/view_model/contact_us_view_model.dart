import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../utils/Util.dart';
import '../../../../utils/app_font_size.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../../utils/dimens.dart';
import '../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/MyText.dart';

class ContactUsViewModel extends GetxController {

  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController(text: "");
  FocusNode nameNode = FocusNode();
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController otherController = TextEditingController(text: "");
  FocusNode emailNode = FocusNode();
  FocusNode otherNode = FocusNode();
  Rx<TextEditingController> phoneController = TextEditingController(text: "").obs;
  FocusNode phoneNode = FocusNode();
  Rx<TextEditingController> altPhoneController = TextEditingController(text: "").obs;
  FocusNode altPhoneNode = FocusNode();
  Rx<TextEditingController> reasonController = TextEditingController(text: "").obs;
  FocusNode reasonNode = FocusNode();
  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  RxString? phoneNumber = ''.obs;

  RxList<String> arrOfMoreOption = List<String>.empty().obs;

  @override
  void onInit() {
    super.onInit();

    arrOfMoreOption.add("False Information");
    arrOfMoreOption.add("Spam");
    arrOfMoreOption.add("Harassment");
    arrOfMoreOption.add("Other");

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
          title: "select_reason".tr,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Padding(
                padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPadding),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: arrOfMoreOption.length,
                  itemBuilder: (BuildContext context, int subIndex) {
                    return GestureDetector(
                      onTap: (){
                        reasonController.value.text = arrOfMoreOption[subIndex];
                        reasonController.refresh();
                        Get.back();

                      },
                      child: Container(
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: 10),
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

  void onSave() {
    if (  formKey.currentState?.validate() == true) {
      Get.back();
      Util.showAlert(title: "form_submitted");
    } else {
      print('not validated');
    }
  }


}
