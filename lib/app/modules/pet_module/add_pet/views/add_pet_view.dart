import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/baseviews/base_view_screen.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/modules/pet_post_registration/pet_type/widgets/pet_type_widget.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/shimmers/pet_tile_shimmer.dart';
import '../../../../components/widgets/custom_button.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../repository/add_pet_repository.dart';
import '../view_model/add_pet_view_model.dart';

class AddPetView extends StatelessWidget {
  AddPetViewModel viewModel = Get.put(AddPetViewModel(repository: Get.find<AddPetRepository>()));

  AddPetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      resizeToAvoidBottomInset:true,
      showAppBar: true,
      centerTitle: true,
      horizontalPadding: false,
      screenName: "add_pets".tr,
      hasBackButton: true.obs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  MyText(
                    text: "which_pet".tr,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    fontSize: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: MyText(
                      text: "tell_us_about".tr,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                  Obx(() =>  viewModel.isDataLoading.value?const PetTileShimmer():Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:  AppDimen.gridCount,
                        mainAxisSpacing: AppDimen.gridSpacing,
                        crossAxisSpacing:AppDimen.gridSpacing,
                        mainAxisExtent:65,
                      ),

                      itemCount: viewModel.arrOfPetType.length,
                      itemBuilder: (context, index) {
                        return PetTypeWidget(viewModel.arrOfPetType[index], (){
                          if(viewModel.arrOfPetType[index].name == "Other"){
                            BottomSheetService.showGenericBottomSheet(
                                child:  CustomBottomSheet(
                                  showHeader:true,
                                  showClose:true,
                                  showAction: true,
                                  verticalPadding:AppDimen.pagesVerticalPadding,
                                  titleSize: AppFontSize.large,
                                  title: "add_other_pet".tr,
                                  widget: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [


                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: MyText(
                                            text: "which_pet_do_you".tr,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: AppDimen.verticalSpacing.h),
                                        Form(
                                          key: viewModel.formKey,
                                          child: CustomTextField(
                                            controller: viewModel.petNameController,
                                            focusNode: viewModel.petNameNode,
                                            hintText: "your_pet_name".tr,
                                            keyboardType: TextInputType.name,
                                            limit: Constants.petName,
                                            validator: (value) {
                                              return HelperFunction.validateValue(value!,"pet_name".tr);
                                            },
                                          ),),
                                      ],
                                    ),
                                  ),
                                  onBtnTap: (){
                                    viewModel.onDoneTap();
                                  },
                                  actionTap: (){
                                    Get.back();
                                  },
                                )
                            );
                          }else{
                            if(viewModel.arrOfPetType[index].isSelected!.value){
                              viewModel.arrOfPetType[index].isSelected!.value = false;
                              viewModel.isTypeSelect.value = false;
                            }else{
                              viewModel.arrOfPetType[index].isSelected!.value = true;

                            }
                          }

                        });
                      },
                    ),
                  )),
                  SizedBox(height: AppDimen.verticalSpacing.h),
                ],
              ),
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
