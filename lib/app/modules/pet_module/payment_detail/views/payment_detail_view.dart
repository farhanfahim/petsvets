import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/argument_constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/single_selection_widget.dart';
import '../../../../data/enums/page_type.dart';
import '../view_model/payment_detail_view_model.dart';

class PaymentDetailView extends StatelessWidget {
  final PaymentDetailViewModel viewModel = Get.put(PaymentDetailViewModel());

  PaymentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      showAppBar: true,
      hasBackButton: true.obs,
      horizontalPadding: false,
      verticalPadding: false,
      backTitle: "txt_cancel".tr,
      centerTitle: true,
      backImage: AppImages.close,
      screenName: "payment_detail".tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimen.pagesVerticalPadding,),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.pagesHorizontalPadding,
                        vertical: AppDimen.pagesVerticalPadding),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "payment".tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                        SizedBox(height: 1.h),
                        Visibility(
                          visible: viewModel.data[ArgumentConstants.pageType] == PageType.subscription ,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: "selected_plan".tr,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  fontSize: 14,
                                ),
                              ),
                              MyText(
                                text: "basic".tr,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: MyText(
                                text: "total_amount".tr,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            const MyText(
                              text: "\$35",
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppDimen.verticalSpacing.h,
                  ),
                  Visibility(
                    visible: viewModel.showAddress.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimen.pagesHorizontalPadding,
                              vertical: AppDimen.pagesVerticalPadding),
                          color: AppColors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
              
                              Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      text: "shipping_address".tr,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.ADD_LOCATION_PCIKER,arguments: false)!.then((value) {

                                        if(value!=null) {
                                          viewModel.loc!.value = value;
                                          viewModel.showLocation.value = true;
                                          viewModel.loc!.refresh();
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        CommonImageView(
                                          svgPath: AppImages.imgPlus,
                                          width: 3.h,
                                        ),
                                        MyText(
                                          text: "add_address".tr,
                                          color: AppColors.red,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top:0),
                                    child: CommonImageView(
                                      imagePath: AppImages.addressLocation,
                                      width: 3.w,
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Obx(() => MyText(
                                                text: viewModel.showLocation.value?viewModel.loc!.value.address!:"no_address".tr,
                                                fontWeight: FontWeight.w600,
                                                color:  AppColors.black,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                              ),)
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2,),
                                      Obx(() => MyText(
                                        text: viewModel.showLocation.value?"":"Add proper address to get accurate branches",
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.gray600,
                                        fontSize: 12,
                                      ),)
                                    ],
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppDimen.verticalSpacing.h,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimen.pagesHorizontalPadding),
                    color: AppColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimen.verticalSpacing.h),
                        MyText(
                          text: "select_payment_method".tr,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                        SizedBox(height: 1.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.arrOfPayment.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SingleSelectionWidget(
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
                                      for (var item in viewModel.arrOfPayment) {
                                        item.isSelected!.value = false;
                                      }
                                      if (viewModel.arrOfPayment[index]
                                          .isSelected!.value) {
                                      } else {
                                        viewModel.arrOfPayment[index].isSelected!
                                            .value = true;
                                      }
                                    }),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: AppDimen.allPadding),
                                  width: double.maxFinite,
                                  height: 0.4,
                                  color: AppColors.grey.withOpacity(0.6),
                                ),
                              ],
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: (){
                            Util.showToast("Will be handled in beta phase");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top:10,bottom: 20),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimen.verticalSpacing.h),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'pay_now'.tr,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                     viewModel.onPayNow();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
