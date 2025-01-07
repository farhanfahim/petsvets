import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../repository/vet_home_repository.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/vet_home_view_model.dart';
import '../widgets/request_tile.dart';

class VetHomeView extends StatelessWidget {

  VetHomeViewModel viewModel = Get.put(VetHomeViewModel(repository: Get.find<VetHomeRepository>()));

  VetHomeView({super.key});

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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.arrOfVets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        RequestTile(
                          model: viewModel.arrOfVets[index],
                          onTap: () {
                            Get.toNamed(Routes.VET_APPOINTMENT_DETAIL,arguments: {
                              ArgumentConstants.type: StatusType.pending
                            });
                          },
                        ), 
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
