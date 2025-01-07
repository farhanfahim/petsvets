import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/Util.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/Skeleton.dart';
import '../../../data/models/vet_response_model.dart';
import '../../../repository/search_repository.dart';
import '../../pet_module/my_appointment/widgets/search_widget.dart';
import '../view_model/search_view_model.dart';
import '../widgets/search_tile.dart';

class SearchView extends StatelessWidget {
  SearchViewModel viewModel = Get.put(SearchViewModel(repository: Get.find<SearchRepository>()));

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
        showAppBar: false,
        horizontalPadding: false,
        verticalPadding: false,
        hasBackButton: false.obs,
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              const SizedBox(height: AppDimen.pagesVerticalPadding,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                child: SearchWidget(
                    focusNode: viewModel.searchNode,
                    color:AppColors.white,
                    showClose: true,
                    showPadding: false,
                    showFilter: false,
                    searchController: viewModel.searchController,
                    onTap: (){},
                    onChange: (v){
                      if(viewModel.vetListController.itemList!=null){
                        viewModel.vetListController.itemList!.clear();
                      }
                      if (viewModel.debounce?.isActive ?? false) viewModel.debounce?.cancel();
                      viewModel.debounce = Timer(const Duration(milliseconds: 500), () {


                        viewModel.searchController.value.text = v;
                        viewModel.searchController.refresh();

                        if(v.isNotEmpty){
                          viewModel.showRecentSearches.value = false;
                        }else{

                          Util.hideKeyBoard(context);
                          viewModel.vetListController.itemList!.clear();
                          viewModel.vetListController.refresh();
                          viewModel.showRecentSearches.value = false;
                        }
                        viewModel.showResults.value = false;
                        viewModel.currentPage = 1;
                        if(v.length>2) {
                          viewModel.getVets();
                        }

                      });

                    },
                    onTapSuffix: (){
                      viewModel.showRecentSearches.value = false;
                      viewModel.showResults.value = false;
                      viewModel.searchController.value.text = "";
                      viewModel.searchController.refresh();
                      Util.hideKeyBoard(context);
                      viewModel.vetListController.itemList!.clear();
                      viewModel.vetListController.refresh();
                    },
                    onTapClose: (){

                      Get.back();
                    }
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: AppDimen.pagesVerticalPadding,),
                     Obx(() =>  Visibility(
                       visible: viewModel.showRecentSearches.value || viewModel.showResults.value,
                       child: Row(
                         children: [
                           Expanded(
                             child: MyText(
                               text: viewModel.showResults.value?"${viewModel.vetListController.value.itemList!.length} ${"result".tr}":"recent_searches".tr,
                               fontWeight: FontWeight.w500,
                               color: !viewModel.showResults.value?AppColors.black:AppColors.gray600,
                               fontSize: 15,
                             ),
                           ),
                           Visibility(
                             visible: !viewModel.showResults.value,
                             child: GestureDetector(
                               onTap: (){
                                 viewModel.showRecentSearches.value = false;
                               },
                               child: MyText(
                                 text: "clear_all".tr,
                                 fontWeight: FontWeight.w400,
                                 color: AppColors.gray600,
                                 fontSize: 14,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),),
                      Obx(() =>  Visibility(
                        visible: viewModel.showRecentSearches.value,
                        child: const SizedBox(height: 5,),
                      ),),
                      Obx(() => Visibility(
                        visible: viewModel.showRecentSearches.value,
                        child: Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.recentSearches.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [

                                ],  /*SearchTile(
                                    isLast: viewModel.recentSearches.length-1 == index,
                                    model: viewModel.recentSearches[index],
                                    onTap: () {
                                      Get.toNamed(Routes.VET_PROFILE);
                                    },
                                  ),*/
                              );
                            },
                          ),
                        ),
                      ),),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              return Future.delayed(const Duration(seconds: 2), () {
                                viewModel.refreshData();
                              });
                            },
                            child: PagedListView<int, VetData>.separated(
                              pagingController: viewModel.vetListController,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              builderDelegate: PagedChildBuilderDelegate<VetData>(
                                itemBuilder: (context_, item, index) {

                                  return Column(
                                    children: [
                                      SearchTile(
                                        isLast: viewModel.vetListController.value.itemList!.length-1 == index,
                                        model: item,
                                        onTap: () {
                                          Get.toNamed(Routes.VET_PROFILE,arguments: {"id":item.id});
                                        },
                                      ),
                                      Obx(() => Visibility(
                                        visible: viewModel.vetListController.value.itemList!.length-1 == index,
                                        child: Visibility(
                                            visible: !viewModel.showResults.value,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.maxFinite,
                                                  height: 0.4,
                                                  color: AppColors.grey.withOpacity(0.6),
                                                ),
                                                const SizedBox(height: AppDimen.contentPadding,),
                                                GestureDetector(
                                                    onTap: (){
                                                      viewModel.showResults.value = true;
                                                      viewModel.showResults.refresh();
                                                    },
                                                    child: MyText(text: "see_all_result".tr,color: AppColors.gray600,fontSize: 14,)),
                                              ],
                                            )
                                        ),
                                      ))
                                    ],
                                  );
                                },
                                noItemsFoundIndicatorBuilder: (context) => SizedBox(
                                  height: 70.h,
                                  child: const Center(
                                    child: MyText(
                                        text: 'No Results Found',
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
                                  return Container();
                                },
                              ),
                              separatorBuilder: (BuildContext context, int index) {
                                return Container();
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),);
  }
}
