import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/argument_constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/single_selection_widget.dart';
import '../../../data/enums/page_type.dart';
import '../view_model/payment_management_view_model.dart';
import '../widgets/payment_tile.dart';

class PaymentManagementView extends StatelessWidget {
  final PaymentManagementViewModel viewModel = Get.put(PaymentManagementViewModel());

  PaymentManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      showAppBar: true,
      hasBackButton: true.obs,
      horizontalPadding: false,
      verticalPadding: false,
      centerTitle: true,
      screenName: "payment_management".tr,
      child: Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewModel.role.value == Constants.rolePet? Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    GestureDetector(
                      onTap:(){
                        Util.showToast("Will be handled in beta phase");
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top:15,bottom: 15,left: 15,right: 15),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            CommonImageView(
                              imagePath: viewModel.arrOfSetting[0].image!,
                              width: 24,
                            ),
                            SizedBox(width: 3.w,),
                            Expanded(
                              child: MyText(
                                text: viewModel.arrOfSetting[0].title!,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            const CommonImageView(
                              svgPath: AppImages.arrowLeft,
                            ),


                          ],
                        ),
                      ),
                    ),
                    Container(

                      width: double.maxFinite,
                      height: 0.4,
                      color: AppColors.grey.withOpacity(0.6),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          MyText(
                            text: "available_cards".tr,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                          SizedBox(height: 1.h),
                          Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.arrOfPayment.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  PaymentTile(
                                      titleFont: 13,
                                      breedFont: 14,
                                      image: index == 0
                                          ? AppImages.applePay
                                          : index == 1
                                          ? AppImages.paypal
                                          : AppImages.master,
                                      showDivider: false,
                                      showPadding: false,
                                      model: viewModel.arrOfPayment[index],
                                      onTap: () {

                                        BottomSheetService.showConfirmationDialog(
                                          title: "remove",
                                          content: "are_you_sure_want_to_remove_this_card",
                                          leftButtonText: "no",
                                          rightButtonText: "yes",
                                          onAgree: () async {
                                            Get.back();
                                            viewModel.arrOfPayment.removeAt(index);
                                            viewModel.arrOfPayment.refresh();
                                            Util.showAlert(title: "card_has_been_removed_successfully");

                                          },
                                        );
                                      }),
                                  Visibility(
                                    visible:viewModel.arrOfPayment.length-1 != index,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: AppDimen.allPadding),
                                      width: double.maxFinite,
                                      height: 0.4,
                                      color: AppColors.grey.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ):Padding(
              padding: const EdgeInsets.symmetric(horizontal:  AppDimen.pagesHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  MyText(
                    text: "account_for_payout".tr,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 10,),
                  PaymentTile(
                      titleFont: 13,
                      breedFont: 14,
                      image: AppImages.paypal,
                      showDivider: false,
                      showPadding: false,
                      model: viewModel.payoutModel,
                      onTap: () {

                        if(viewModel.payoutModel.isSelected!.isTrue){
                          BottomSheetService.showConfirmationDialog(
                            title: "remove",
                            content: "are_you_sure_want_to_remove_this_card",
                            leftButtonText: "no",
                            rightButtonText: "yes",
                            onAgree: () async {
                              Get.back();
                              viewModel.payoutModel.isSelected!.value = false;

                            },
                          );
                        }else{
                          viewModel.payoutModel.isSelected!.value = true;
                        }

                      }),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
