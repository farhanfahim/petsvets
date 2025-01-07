import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/text_field_label.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';

class CustomDeleteTextField extends StatelessWidget {
  final String? fieldText;
  final String? hintText, label;
  final bool isMandatory;
  final bool isFinal;
  final bool? isNumberInput;
  final bool enabled;
  final bool readOnly;
  final FormFieldValidator<String>? validator;
  final int? limit;
  final String filteringRegex;
  final int maxLines;
  final int minLines;
  final String? icon;
  final Widget? postPixText;
  final IconData? iconData;
  final void Function()? sufixIconOnTap;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final bool? isPassword;
  final bool? isCaps;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final Color? lableColor;
  final double lableFontSize;
  final double? iconSize;
  final double? iconHeight;
  final double suffixConstraint;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? color;

  const CustomDeleteTextField({
    super.key,
    this.fieldText,
    this.hintText,
    this.isMandatory = true,
    this.isFinal = false,
    this.readOnly = false,
    this.validator,
    this.isNumberInput = false,
    this.enabled = true,
    this.label,
    this.isCaps = false,
    this.onChanged,
    this.icon,
    this.postPixText,
    this.iconData,
    this.sufixIconOnTap,
    this.onTap,
    this.isPassword = false,
    this.limit = 20,
    this.filteringRegex = "",
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.nextFocusNode,
    this.controller,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.lableColor,
    this.lableFontSize = AppFontSize.extraSmall,
    this.iconHeight,
    this.iconSize,
    this.prefixWidget,
    this.suffixWidget,
    this.suffixConstraint = 45,
    this.color = AppColors.fieldsBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Visibility(
          visible: label != null && label!.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: TextFieldLabel(label: label ?? "",mandatory: isMandatory,),
          ),
        ),
        TextFormField(
          textCapitalization: isCaps! ? TextCapitalization.sentences : TextCapitalization.none,
          obscureText: isPassword!,
          focusNode: focusNode,
          onTap: onTap,
          validator: validator,
          enabled: enabled,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.black,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          minLines: minLines,
          onChanged: onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(filteringRegex)),
            LengthLimitingTextInputFormatter(limit),
          ],
          onFieldSubmitted: onFieldSubmitted,
           textInputAction: isFinal ? TextInputAction.done : textInputAction,
          style: TextStyle(
            fontSize: lableFontSize,
            color: lableColor ?? AppColors.black,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.fontMulish,
          ),
          decoration: InputDecoration(
            fillColor: color,
            filled: true,
            prefixIconConstraints: const BoxConstraints(minWidth: 15, minHeight: 38),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5, right: 10),
              child: prefixWidget,
            ),

            labelText: fieldText,
            hintText: hintText,
            suffixIconConstraints: icon != null
                ? BoxConstraints(
                    minWidth: suffixConstraint,
                    minHeight: suffixConstraint,
                  )
                : const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: GestureDetector(
              onTap: sufixIconOnTap,
              child: suffixWidget??Container(
                width: iconSize ?? 10.0,
                height: 35.0,
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.only(right: 15.0, left: 0, bottom: 0, top: 5),
                child: postPixText != null
                    ? Align(alignment: Alignment.centerRight, child: postPixText)
                    : icon == null
                        ? iconData == null
                            ? Container()
                            : Icon(iconData)
                        : SvgPicture.asset(
                            icon!,
                            width: 30,
                            height: 30,
                            matchTextDirection: true,
                          ),
              ),
            ),
            hintStyle: _setHintStyle(),
            alignLabelWithHint: true,
            errorMaxLines: 2,
            errorStyle: const TextStyle(color: AppColors.error),
            labelStyle: TextStyle(fontSize: lableFontSize.sp, color: lableColor ?? AppColors.grey, fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
              borderSide: const BorderSide(width: 1.0, color: AppColors.error),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
              borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
              borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
              borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
              borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
            ),
          ),
        ),
      ],
    );
  }

  _setHintStyle() {
    return const TextStyle(
      fontSize: AppFontSize.extraSmall,
      color: AppColors.grey,
      fontFamily: AppFonts.fontMulish,
      fontWeight: FontWeight.w400,
    );
  }
}
