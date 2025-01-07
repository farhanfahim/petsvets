import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/appointment_tile.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../repository/pet_appointment_repository.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/appointment_history_view_model.dart';

class AppointmentHistoryView extends StatelessWidget {


  AppointmentHistoryViewModel viewModel = Get.put(AppointmentHistoryViewModel(repository: Get.find<PetAppointmentRepository>()));

  AppointmentHistoryView({super.key});


  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        screenName: "appointment_history".tr,
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
       );
  }
}
