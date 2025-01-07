import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:petsvet_connect/app/data/models/address_response_model.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/Util.dart';
import '../../../../utils/app_font_size.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../data/models/location.dart';
import '../../../repository/address_repository.dart';
import '../view_model/addresses_view_model.dart';
import '../widgets/address_tile.dart';

class AddressesView extends StatelessWidget {
  AddressesViewModel viewModel = Get.put(AddressesViewModel(repository: Get.find<AddressRepository>()));

  AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        centerTitle: true,
        horizontalPadding: false,
        screenName: "addresses".tr,
        child: Container(
          color: AppColors.white,
          margin: const EdgeInsets.only(top: AppDimen.contentPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimen.pagesVerticalPadding,),
              Container(
                width: double.maxFinite,
                color: AppColors.white,
                padding: const EdgeInsets.only(left:AppDimen.pagesHorizontalPadding),
                child: MyText(
                  text: "saved_addresses".tr,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),

              RefreshIndicator(
                onRefresh: () async {
                  return Future.delayed(const Duration(seconds: 2), () {

                    viewModel.refreshData();
                  });
                },
                child: PagedListView<int, AddressData>.separated(
                  pagingController: viewModel.arrOfAddress,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<AddressData>(
                    itemBuilder: (context_, item, index) {
                      return AddressTile(model:item,onTap: () {
                        BottomSheetService.showGenericBottomSheet(
                            child: CustomBottomSheet(
                              showHeader: true,
                              showClose: false,
                              showAction: true,
                              showBottomBtn: false,
                              centerTitle: false,
                              titleSize: AppFontSize.small,
                              actionText: "cancel".tr,
                              actionColor: AppColors.gray600,
                              verticalPadding: AppDimen.pagesVerticalPadding,
                              title: "select_action".tr,
                              widget: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
                                itemCount: viewModel.arrOfOption.length,
                                itemBuilder: (BuildContext context, int subIndex) {
                                  return GestureDetector(
                                    onTap: (){
                                      if(subIndex == 0){
                                         for(var item in viewModel.arrOfAddress.itemList!){
                                              item.isSelected!.value = false;
                                            }
                                            viewModel.arrOfAddress.itemList![index].isSelected!.value = true;
                                         viewModel.updateAddressAPI(viewModel.arrOfAddress.itemList![index].id!,true);
                                        Get.back();
                                      }else{
                                        Get.back();
                                        BottomSheetService.showConfirmationDialog(
                                          title: "delete_address",
                                          content: "are_you_sure_want_to_delete_address",
                                          leftButtonText: "cancel",
                                          rightButtonText: "delete",
                                          onAgree: () async {
                                            Get.back();
                                            viewModel.deleteAddressAPI(viewModel.arrOfAddress.itemList![index].id!);
                                            viewModel.arrOfAddress.itemList!.remove(viewModel.arrOfAddress.itemList![index]);
                                            viewModel.arrOfAddress.refresh();
                                            Util.showAlert(title: "your_address_has_been_deleted");
                                          },
                                        );

                                      }
                                    },
                                    child: Container(
                                      color: AppColors.white,
                                      padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                                      child: MyText(
                                        text: viewModel.arrOfOption[subIndex],
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              actionTap: () {
                                Get.back();
                              },
                            ));
                      },);
                    },
                    noItemsFoundIndicatorBuilder: (context) =>
                        Container(),
                    newPageProgressIndicatorBuilder: (context) =>
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: SizedBox(
                          width: 15.0,
                          height: 15.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
                    ),
                    firstPageProgressIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),

                            const SizedBox(height: 10.0,),

                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),

                            const SizedBox(height: 10.0,),

                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
              ),

              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ADD_LOCATION_PCIKER,arguments: true)!.then((value){
                    if(value!=null) {
                      viewModel.arrOfAddress.itemList!.clear();
                      viewModel.getAddress();
                    }
                  });

                },
                child: Container(
                  width: double.maxFinite,
                  color: AppColors.white,
                  padding: const EdgeInsets.only(top: AppDimen.pagesVerticalPaddingNew,bottom: AppDimen.pagesVerticalPaddingNew,left:AppDimen.pagesHorizontalPadding,),
                  child: Row(
                    children: [
                      CommonImageView(
                        svgPath: AppImages.imgPlus,
                        width: 3.h,
                      ),
                      MyText(
                        text: "add_new_address".tr,
                        color: AppColors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
