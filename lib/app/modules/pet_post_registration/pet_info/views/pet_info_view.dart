import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/baseviews/base_view_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/shimmers/text_shimmer.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/dimens.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/single_selection_widget.dart';
import '../../../../data/models/breed_model.dart';
import '../../../../repository/pet_post_registration_repository.dart';
import '../view_model/pet_info_view_model.dart';
import '../widgets/breed_single_selection_widget.dart';
import '../widgets/pet_info_widget.dart';

class PetInfoView extends StatelessWidget {
  PetInfoViewModel viewModel = Get.put(PetInfoViewModel(repository: Get.find<PetPostRegistrationRepository>()));

  PetInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      horizontalPadding: false,
      verticalPadding: false,
      backgroundColor: AppColors.white,
      hasBackButton: false.obs,
      resizeToAvoidBottomInset: true,
      showAppBar: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimen.verticalSpacing.h),
                      MyText(
                        text: "tell_bit_more".tr,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: MyText(
                          text: "tell_us_more".tr,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimen.verticalSpacing.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.petTypeViewModel.arrOfSelectedPetType.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(viewModel.petTypeViewModel.arrOfSelectedPetType[index].id==null?true:false);
                      return Visibility(
                        visible: viewModel.petTypeViewModel.arrOfSelectedPetType[index].isSelected!.value,
                        child: Obx(() => PetInfoWidget(

                          isCustom: viewModel.petTypeViewModel.arrOfSelectedPetType[index].id==null?true:false,
                          isLast: viewModel.getSelectedLength() == index,
                          petName: viewModel.petTypeViewModel.arrOfSelectedPetType[index].name,
                          breed: viewModel.petTypeViewModel.arrOfSelectedPetType[index].breed!=null?viewModel.petTypeViewModel.arrOfSelectedPetType[index].breed!:"".obs,
                          onTap: () {},
                          onChangeValue: (v) {
                            if(viewModel.petTypeViewModel.arrOfSelectedPetType[index].id==null){
                              viewModel.petTypeViewModel.arrOfSelectedPetType[index].breed = v.obs;
                            }
                          },
                          onTapSelectBreed: () {
                            if(viewModel.petTypeViewModel.arrOfSelectedPetType[index].id!=null){
                              viewModel.getBreed(pos: index);
                            }

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
                                  actionText: "save".tr,
                                  actionColor: AppColors.red,
                                  verticalPadding: AppDimen.pagesVerticalPadding,
                                  title: "select_breed".tr,
                                  widget: Obx(() => viewModel.isDataLoading.value?const TextShimmer():ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: viewModel.arrOfBreed.length,
                                    itemBuilder: (BuildContext context, int subIndex) {
                                      return BreedSingleSelectionWidget(
                                          model: viewModel.arrOfBreed[subIndex],
                                          onTap: () {
                                            for (var item in viewModel.arrOfBreed) {
                                              item.isSelected!.value = false;
                                            }
                                            if (viewModel.arrOfBreed[subIndex].isSelected!.value) {
                                              viewModel.arrOfBreed[subIndex].isSelected!.value = false;
                                            } else {
                                              viewModel.arrOfBreed[subIndex].isSelected!.value = true;
                                            }
                                            viewModel.arrOfBreed.refresh();
                                          });
                                    },
                                  ),),
                                  actionTap: () {
                                    BreedData selectedItem = viewModel.arrOfBreed.firstWhere(
                                          (item) => item.isSelected!.value,
                                    );
                                    if(selectedItem!=null) {
                                      viewModel.petTypeViewModel.arrOfSelectedPetType[index].breedId = selectedItem.id;
                                      viewModel.petTypeViewModel.arrOfSelectedPetType[index].breed = selectedItem.name!.obs;
                                      viewModel.petTypeViewModel.arrOfSelectedPetType.refresh();
                                    }
                                    Get.back();
                                  },
                                  leadingTap: () {

                                    Get.back();
                                  },
                                ));
                          },
                          onTapAddNew: () {
                            viewModel.accountSetupViewModel.changePage(0);
                          },
                        ),)
                      );
                    },
                  ),
                ),
                SizedBox(height: AppDimen.verticalSpacing.h),
              ],
            ),
          ),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

            child: CustomButton(
              label: 'next'.tr,
              textColor: AppColors.white,
              fontWeight: FontWeight.w600,
              onPressed: () {
                viewModel.onTapNext();
              },
            ),
          ),
        ],
      ),
    );
  }
}
