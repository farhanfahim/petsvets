import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/dialogs/delete_account/delete_account_dialog_controller.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_fonts.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/custom_textfield.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:petsvet_connect/utils/helper_functions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/custom_delete_textfield.dart';

class DeleteAccountDialog extends StatelessWidget {
  final void Function()? onCancelTap;
  final void Function() onConfirmTap;

  DeleteAccountDialog({
    Key? key,
    this.onCancelTap,
    required this.onConfirmTap,
  }) : super(key: key);

  final DeleteAccountDialogController controller = Get.put(DeleteAccountDialogController());

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: MyText(
        text: "are_you_sure_like_to_cont".tr,
        fontFamily: AppFonts.fontMulish,
        fontWeight: FontWeight.w700,
        color: AppColors.blackColor,
        center: true,
        fontSize: AppFontSize.small,
      ),
      content: Card(
        elevation: 0,
        color: AppColors.transparent,
        child: Column(
          children: [
            MyText(
              text: "deleting_account_undone".tr,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
              center: true,
              fontSize: AppFontSize.verySmall,
            ),
            const SizedBox(height: 10),
            MyText(
              text: "to_continue_type_delete".tr,
              fontFamily: AppFonts.fontMulish,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
              center: true,
              fontSize: AppFontSize.verySmall,
            ),
            const SizedBox(height: 10),
            Form(
              key: controller.formKey,
              child: CustomDeleteTextField(
                controller: controller.fieldController,
                focusNode: controller.fieldFocus,
                isFinal: true,
                hintText: "type_delete".tr,
                validator: (value) {
                  return HelperFunction.stringValidateWithDelete(value!,);
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onCancelTap,
          child: MyText(
            text: "cancel".tr,
            fontFamily: AppFonts.fontMulish,
            fontWeight: FontWeight.w600,
            color: AppColors.red,
            fontSize: AppFontSize.regular,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            if (controller.formKey.currentState?.validate() == true) {
              onConfirmTap();
            }
          },
          child: MyText(
            text: "delete".tr,
            fontFamily: AppFonts.fontMulish,
            fontWeight: FontWeight.w600,
            color: AppColors.red,
            fontSize: AppFontSize.regular,
          ),
        ),
      ],
    );
  }
}
