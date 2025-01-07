import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/Util.dart';
import '../../../../utils/app_font_size.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../../utils/dimens.dart';
import '../../../../utils/helper_functions.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/alt_phone_number_field.dart'; 
import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/custom_textfield.dart';
import '../view_model/contact_us_view_model.dart';


class ContactUsView extends StatelessWidget {
  final ContactUsViewModel viewModel = Get.put(ContactUsViewModel());

  ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        screenName: "contact_us".tr,
        horizontalPadding: false,
        resizeToAvoidBottomInset: true,
        centerTitle: true,
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              const SizedBox(height: AppDimen.pagesVerticalPadding,),
             Expanded(child:  Container(
               padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     MyText(
                       text: "let_us_know".tr,
                       fontSize: 14,
                       color: AppColors.gray600,
                       fontWeight: FontWeight.w400,
                     ),
                     SizedBox(height: AppDimen.verticalSpacing.h),
                     CustomTextField(
                       controller: viewModel.nameController,
                       focusNode: viewModel.nameNode,
                       nextFocusNode: viewModel.emailNode,
                       hintText: "txt_your_full_name".tr,
                       label: "txt_full_name".tr,
                       keyboardType: TextInputType.name,
                       limit: Constants.fullNameLimit,
                       validator: (value) {
                         return HelperFunction.validateValue(value!,"txt_full_name".tr);
                       },
                     ),
                     SizedBox(height: AppDimen.verticalSpacing.h),
                     CustomTextField(
                       controller: viewModel.emailController,
                       focusNode: viewModel.emailNode,
                       hintText: "enter_email_address".tr,
                       label: "email_address".tr,
                       keyboardType: TextInputType.emailAddress,
                       limit: Constants.emailAddressLimit,
                       nextFocusNode: viewModel.phoneNode,
                       validator: (value) {
                         return HelperFunction.emailValidate(value!);
                       },
                     ),
                     SizedBox(height: AppDimen.verticalSpacing.h),
                     Obx(() => AltPhoneNumberField(
                       mandatory:true,
                       controller: viewModel.phoneController,
                       controller2: viewModel.altPhoneController,
                       label:"phone_number".tr,
                       focusNode: viewModel.phoneNode,
                       initialPhone: viewModel.initialPhone.value,
                       onInputChanged: (v){
                         viewModel.phoneNumber!.value = v.toString();
                         viewModel.phoneController.refresh();
                       },),),
                     SizedBox(height: AppDimen.verticalSpacing.h),
                     Obx(() => CustomTextField(
                       controller: viewModel.reasonController.value,
                       focusNode: viewModel.reasonNode,
                       nextFocusNode: viewModel.otherNode,
                       hintText: "select_reason".tr,
                       label: "select_reason".tr,
                       isFinal:  viewModel.reasonController.value.text == "Other"?false:true,
                       keyboardType: TextInputType.number,
                       limit: Constants.stateNumber,
                       readOnly: true,
                       onTap: (){
                         viewModel.moreReportOption();
                       },

                       validator: (value) {
                         return HelperFunction.validateValue(value!,"reason".tr);

                       },
                       icon: AppImages.arrowDown,
                     ),),
                     const SizedBox(height: 10,),
                     Obx(() => Visibility(
                       visible: viewModel.reasonController.value.text == "Other",
                       child:  CustomTextField(
                         controller: viewModel.otherController,
                         focusNode: viewModel.otherNode,
                         isFinal:  viewModel.reasonController.value.text == "Other"?true:false,
                         hintText: "provide_additional_details".tr,
                         keyboardType: TextInputType.name,
                         limit: Constants.descriptionLimit,
                         validator: (value) {
                           return HelperFunction.validateValue(value!,"additional_details".tr);
                         },
                       ),))
                   ],
                 ),
               ),
             ),),

              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'submit'.tr,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  //controller: viewModel.btnController,
                  onPressed: () {
                    Util.hideKeyBoard(context);
                    viewModel.onSave();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
