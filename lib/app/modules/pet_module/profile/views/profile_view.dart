import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/shimmers/listing_shimmer.dart';
import 'package:petsvet_connect/app/data/models/pet_model.dart';
import 'package:petsvet_connect/app/data/models/pet_response_model.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../repository/pet_profile_repository.dart';
import '../view_model/profile_view_model.dart';
import '../widgets/pet_tile_widget.dart';
import '../widgets/profile_view_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileViewModel viewModel = Get.put(ProfileViewModel(repository: Get.find<PetProfileRepository>()));

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.backgroundColor,
        showAppBar: true,
        horizontalPadding: false,
        hasBackButton: true.obs,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileViewWidget(
                userModel: viewModel.userModel,
                onTap: () {
                  Get.toNamed(Routes.EDIT_PROFILE);
                },
              ),
              const SizedBox(
                height: AppDimen.pagesVerticalPadding,
              ),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.only(
                    top: AppDimen.pagesVerticalPadding,
                    left: AppDimen.pagesHorizontalPadding,
                    right: AppDimen.pagesHorizontalPadding,
                    bottom: AppDimen.pagesVerticalPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyText(
                        text: "pets".tr,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        Get.toNamed(Routes.ADD_PET,arguments: {ArgumentConstants.list:viewModel.arrOfPetType})!.then((value) {
                          if(value!=null) {
                            viewModel.arrOfPetType.clear();
                            Util.showAlert(title: "pet_added_successfully");
                            viewModel.getBPets();

                          }
                        });

                      },
                      child: Row(
                        children: [
                          const CommonImageView(
                            svgPath: AppImages.imgPlus,
                            width: 20,
                          ),
                          MyText(
                            text: "add_new".tr,
                            color: AppColors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
             Obx(() =>  viewModel.isDataLoading.value?const ListingShimmer():ListView.builder(
               shrinkWrap: true,
               itemCount: viewModel.arrOfPetType.length,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (BuildContext context, int index) {
                 return PetTileWidget(
                   isLast: viewModel.arrOfPetType.length - 1 == index,
                   model: viewModel.arrOfPetType[index],
                   onTap: () {
                     BottomSheetService.showConfirmationDialog(
                       title: "remove",
                       content: "are_you_sure_you_want_to_remove",
                       leftButtonText: "cancel",
                       rightButtonText: "remove",
                       onAgree: () async {
                         print(viewModel.arrOfPetType[index].toJson());
                         viewModel.deletePetAPI(viewModel.arrOfPetType[index].id!,index);
                         Get.back();
                         Util.showAlert(title: "pet_hase_been_removed");
                         viewModel.arrOfPetType.removeAt(index);
                       },
                     );
                   },
                 );
               },
             ),)
            ],
          ),
        ));
  }
}
