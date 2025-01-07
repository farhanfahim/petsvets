import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/appointment_tile.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/search_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/my_bookings_view_model.dart';
import '../widgets/booking_tile.dart';

class MyBookingsView extends StatelessWidget {
  final MyBookingsViewModel viewModel = Get.put(MyBookingsViewModel());

  MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.backgroundColor,
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child: Obx(
          () =>  Column(
            children: [
              SearchWidget(
                  focusNode: viewModel.searchNode,
                  color:AppColors.white,
                  showClose: false,
                  showFilter: true,
                  searchController:  viewModel.searchController,
                  onTap: (){
                    Get.toNamed(Routes.FILTER);
                  },
                  onChange: (v) {
                    viewModel.searchController.value.text = v;
                    viewModel.searchController.refresh();
                  },
                  onTapSuffix: () {
                    viewModel.searchController.value.text = "";
                    viewModel.searchController.refresh();
                    Util.hideKeyBoard(context);
                  },
                  onTapClose: (){}
              ),

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.arrOfVets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        BookingTile(
                          model: viewModel.arrOfVets[index],
                          onTap: () {
                            Get.toNamed(Routes.VET_APPOINTMENT_DETAIL,arguments: {
                              ArgumentConstants.type: viewModel.arrOfVets[index].type
                            });
                          },
                        ),
                        Visibility(
                            visible:viewModel.arrOfVets.length-1 == index,
                            child: SizedBox(height: 1.h,))
                      ],
                    );
                  },
                ),
              ),

            ],
          )
        ));
  }
}
