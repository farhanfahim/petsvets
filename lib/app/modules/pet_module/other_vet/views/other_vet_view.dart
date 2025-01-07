import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../data/models/vet_response_model.dart';
import '../../../../repository/pet_home_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../home/widgets/vet_tile.dart';
import '../view_model/other_vet_view_model.dart';

class OtherVetView extends StatelessWidget {
  OtherVetViewModel viewModel = Get.put(OtherVetViewModel(repository: Get.find<PetHomeRepository>()));

  OtherVetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.backgroundColor,
        horizontalPadding: false,

        hasBackButton: true.obs,
        titleColor: AppColors.blackColor,
        appBarBackgroundColor: AppColors.white,
        backIconColor: AppColors.blackColor,
        screenName: "other_vets".tr,
        centerTitle: true,
        showAppBar: true,
        child: RefreshIndicator(
          onRefresh: () async {
            return Future.delayed(const Duration(seconds: 2), () {
              viewModel.refreshData();
            });
          },
          child: PagedListView<int, VetData>.separated(
            pagingController: viewModel.vetListController,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<VetData>(
              itemBuilder: (context_, item, index) {
                if(item.latitude!=null) {
                  viewModel.getAddressFromLatLng(
                      Get.context, item.latitude!, item.longitude!).then((value) {
                    item.address!.value = value;
                    item.address!.refresh();
                  });
                }

                return Column(
                  children: [
                    VetTile(
                      model: item,
                      onTap: () {
                        Get.toNamed(Routes.VET_PROFILE,arguments: {"id":item.id!});
                      },
                    ),
                    Visibility(
                        visible:viewModel.vetListController.itemList!.length-1 == index,
                        child: SizedBox(height: 10.h,))
                  ],
                );
              },
              noItemsFoundIndicatorBuilder: (context) => SizedBox(
                height: 70.h,
                child: const Center(
                  child: MyText(
                      text: 'No Vet Found',
                      fontSize: 12,
                      center: true,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor
                  ),
                ),
              ),
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
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: double.maxFinite,
                        child: Skeleton(),
                      ),

                      SizedBox(height: 10.0,),

                      SizedBox(
                        height: 50.0,
                        width: double.maxFinite,
                        child: Skeleton(),
                      ),

                      SizedBox(height: 10.0,),

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
        ));
  }
}
