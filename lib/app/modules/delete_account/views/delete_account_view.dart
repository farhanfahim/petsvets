import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/dialogs/delete_account/delete_account_dialog.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/single_selection_widget.dart';
import '../view_model/delete_account_view_model.dart';

class DeleteAccountView extends StatelessWidget {
  final DeleteAccountViewModel viewModel = Get.put(DeleteAccountViewModel());

  DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        showAppBar: true,
        horizontalPadding: false,
        hasBackButton: true.obs,
        backgroundColor: AppColors.white,
        centerTitle: true,
        screenName: "delete_account".tr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimen.pagesVerticalPadding,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.pagesHorizontalPadding),
              child: MyText(
                text: "why_did_you".tr,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: AppDimen.horizontalSpacing,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.pagesHorizontalPadding),
              child: MyText(
                text: "share_your_option".tr,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: AppDimen.horizontalSpacing,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.arrOfOption.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimen.pagesHorizontalPadding, vertical: 8),
                  child: SingleSelectionWidget(
                      showDivider: false,
                      showPadding: false,
                      model: viewModel.arrOfOption[index],
                      onTap: () {
                        viewModel.onSelect(index);
                      }),
                );
              },
            ),
            const Spacer(),
            Obx(
              () => Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'submit'.tr,
                  textColor: !viewModel.showSubmit.value
                      ? AppColors.fieldsHeadingColor
                      : AppColors.white,
                  fontWeight: FontWeight.w600,
                  color: !viewModel.showSubmit.value
                      ? AppColors.textFieldBorderColor
                      : AppColors.red,
                  //controller: viewModel.btnController,
                  onPressed: () {
                    if (viewModel.showSubmit.value) {
                      BottomSheetService.showGenericDialog(
                        child: DeleteAccountDialog(
                          onCancelTap: () {
                            Get.back();
                          },
                          onConfirmTap: () {
                            viewModel.onConfirm();
                             
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
