import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petsvet_connect/app/components/widgets/text_field_label.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/utils/app_decorations.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

class AltPhoneNumberField extends StatelessWidget {
  AltPhoneNumberField({
    super.key,
    required this.focusNode,
    required this.label,
    required this.mandatory,
    required this.controller,
    required this.controller2,
    required this.initialPhone,
    this.onInputChanged,
    this.textInputAction = TextInputAction.next,
  });

  final FocusNode focusNode;
  final bool mandatory;
  Rx<TextEditingController> controller = TextEditingController(text: "").obs;
  Rx<TextEditingController> controller2 = TextEditingController(text: "").obs;
  final String label;
  final PhoneNumber initialPhone;
  final void Function(PhoneNumber)? onInputChanged;
  final TextInputAction textInputAction;

  RxBool isValid = true.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: TextFieldLabel(label: label ?? "",mandatory: mandatory,),
        ),
        Obx(() => InternationalPhoneNumberInput(
          textAlign: TextAlign.start,
          focusNode: focusNode,
          textFieldController: controller.value,

          textStyle: const TextStyle(
            fontSize: AppFontSize.extraSmall,
            color:  AppColors.black,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.fontMulish,
          ),
          selectorTextStyle: TextStyle(
              fontSize: AppFontSize.extraSmall, fontWeight: FontWeight.w400, fontFamily: AppFonts.fontMulish, color: AppColors.fieldsHeadingColor),
          cursorColor: AppColors.grey,
          initialValue: initialPhone,
          formatInput: false,
          ignoreBlank: false,
          errorMessage:  "invalid_phone_number".tr ,
          countrySelectorScrollControlled: true,
          onInputChanged: onInputChanged,
          onFieldSubmitted: (_) {
            //FocusScope.of(context).requestFocus(controller.passwordNode);
          },
          onInputValidated: (bool value) {

            if(value){
              isValid.value = true;
            }else{
              isValid.value = false;
            }
          },
          validator: (String? value) {
            // Custom validation logic
            if (value == null || value.isEmpty) {
              if(mandatory){
                return "$label ${"field_cannot_be_empty".tr}".tr;
              }else{
                return null; // No validation error for empty input
              }

            }
            if(controller.value.text == controller2.value.text){
              if(mandatory){
                return "The phone number must be different from the alternate phone number.";
              }else{
                return "The alternate phone number must be different from the phone number.";
              }

            }
            if(!isValid.value){
              return "invalid_phone_number".tr;
            }
            return null;
          },
          selectorConfig: const SelectorConfig(
            leadingPadding: 20,
            showFlags: true,
            trailingSpace: false,
            useBottomSheetSafeArea: true,
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            setSelectorButtonAsPrefixIcon: true,
          ),
          keyboardAction: textInputAction,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          searchBoxDecoration: AppDecorations.phoneSearchDecoration(),
          inputDecoration: AppDecorations.phoneInputDecoration(),
        ),)

      ],
    );
  }
}
