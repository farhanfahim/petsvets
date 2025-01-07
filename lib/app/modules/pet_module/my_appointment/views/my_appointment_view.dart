import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/appointment_tile.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/search_widget.dart';
import 'package:petsvet_connect/app/repository/pet_appointment_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../routes/app_pages.dart';
import '../../home/widgets/map_button_widget.dart';
import '../view_model/my_appointment_view_model.dart';

class MyAppointmentView extends StatelessWidget {
  MyAppointmentViewModel viewModel = Get.put(MyAppointmentViewModel(repository: Get.find<PetAppointmentRepository>()));

  MyAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child: Stack(
          children: [
            Column(
              children: [
                SearchWidget(
                    focusNode: viewModel.searchNode,
                    color:AppColors.white,
                    showClose: false,
                    showFilter: true,
                    searchController:  viewModel.searchController,
                    onTap: (){
                      Get.toNamed(Routes.FILTER)!.then((value) {
                        if(value!=null) {
                          viewModel.vetListController.itemList!.clear();
                          if (value != 0) {
                            PetTypeModel model = value;
                            viewModel.currentPage = 1;
                            if (model.title == 'Pending') {
                              viewModel.getVets(type: 10);
                            }
                            if (model.title == 'Cancelled') {
                              viewModel.getVets(type: 20);
                            }
                            if (model.title == 'Confirmed') {
                              viewModel.getVets(type: 30);
                            }
                          } else {
                            viewModel.getVets(type: 0);
                          }
                        }
                      });
                    },
                    onChange: (v) {

                      if(v.length>2) {
                        if(viewModel.vetListController.itemList!=null){
                          viewModel.vetListController.itemList!.clear();
                        }
                        if (viewModel.debounce?.isActive ?? false) viewModel.debounce?.cancel();
                        viewModel.debounce = Timer(const Duration(milliseconds: 500), () {


                          viewModel.searchController.value.text = v;
                          viewModel.searchController.refresh();
                          Util.hideKeyBoard(context);
                          viewModel.vetListController.itemList!.clear();
                          viewModel.vetListController.refresh();
                          viewModel.currentPage = 1;


                        });
                      }
                    },
                    onTapSuffix: () {

                      viewModel.searchController.value.text = "";
                      viewModel.searchController.refresh();
                      Util.hideKeyBoard(context);
                      viewModel.vetListController.itemList!.clear();
                      viewModel.vetListController.refresh();

                    },
                    onTapClose: (){}
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      return Future.delayed(const Duration(seconds: 2), () {
                        viewModel.refreshData();
                      });
                    },
                    child: PagedListView<int, AppointmentData>.separated(
                      pagingController: viewModel.vetListController,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<AppointmentData>(
                        itemBuilder: (context_, item, index) {
                          return Column(
                            children: [
                              AppointmentTile(
                                model: item,
                                onTap: () {
                                  Get.toNamed(Routes.APPOINTMENT_DETAIL,arguments: {
                                    ArgumentConstants.type: item
                                  });
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
                                text: 'No Appointments Found',
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
                  ),
                ),

              ],
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MapButtonWidget(
                      title:"view_history".tr,
                      image: AppImages.history,
                      onTap: () {
                        Get.toNamed(Routes.APPOINTMENT_HISTORY);
                      },
                    ),

                  ],
                )),


          ],
        ));
  }
}
