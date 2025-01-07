import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/multi_selection_widget.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/custom_button.dart';
import '../view_model/filter_view_model.dart';

class FilterView extends StatelessWidget {
  final FilterViewModel viewModel = Get.put(FilterViewModel());

  FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        backImage:AppImages.close,
        backTitle:"txt_cancel".tr,
        titleColor: AppColors.blackColor,
        appBarBackgroundColor: AppColors.white,
        backIconColor: AppColors.blackColor,
        screenName: "sort_filter".tr,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        hasBackButton: true.obs,
        child: Obx(
          () =>  Column(
            children: [
              const SizedBox(height: AppDimen.pagesVerticalPadding,),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.arrOfFilter.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MultiSelectionWidget(
                      hideDivider: true,
                       model:viewModel.arrOfFilter[index],
                       onTap: () {

                         if(viewModel.arrOfFilter[index].isSelected!.value){
                           viewModel.arrOfFilter[index].isSelected!.value = false;
                         }else{
                           viewModel.arrOfFilter[index].isSelected!.value = true;
                         }
                       },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimen.verticalSpacing,),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: Row(

                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'reset'.tr,
                        borderColor: AppColors.red,
                        color: AppColors.white,
                        textColor: AppColors.red,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Get.back(result: 0);
                        },
                      ),
                    ),
                    const SizedBox(width: AppDimen.allPadding,),
                    Expanded(
                      child: CustomButton(
                        label: 'show_results'.tr,
                        textColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Rx<PetTypeModel> model = PetTypeModel().obs;
                          for(var item in viewModel.arrOfFilter){
                            if(item.isSelected!.value){
                              model.value = item;
                            }
                          }
                          model.refresh();
                          Get.back(result: model.value);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ],
          )
        ));
  }
}
