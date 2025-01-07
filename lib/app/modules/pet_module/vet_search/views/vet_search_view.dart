import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/modules/pet_module/vet_search/widgets/search_widget.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/Util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../repository/pet_home_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../home/widgets/map_button_widget.dart';
import '../../home/widgets/vet_tile.dart';
import '../../no_location/views/no_location_view.dart';
import '../view_model/vet_search_view_model.dart';

class VetSearchView extends StatefulWidget {

  const VetSearchView({super.key});

  @override
  State<VetSearchView> createState() => _vetSearchViewState();
}

class _vetSearchViewState extends State<VetSearchView> with AutomaticKeepAliveClientMixin<VetSearchView> {
  VetSearchViewModel viewModel = Get.put(VetSearchViewModel(repository: Get.find<PetHomeRepository>()));


  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child: Obx(
          () => viewModel.hasPermission.value
              ? Stack(
                  children: [
                    Obx(() => !viewModel.showLoader.value
                        ? GoogleMap(
                      onMapCreated: viewModel.onMapCreated,
                      markers: viewModel.getMarkers(false),
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      mapType: MapType.normal,
                      onTap: (v) {
                        Get.toNamed(Routes.VET_SEARCH);
                      },
                      initialCameraPosition: CameraPosition(
                        target: viewModel.latLng!.value,
                        zoom: 14.0,
                      ),
                    )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MapButtonWidget(
                              image: AppImages.gpsDark,
                              onTap: () {
                                viewModel.showCard.value = false;
                                viewModel.toTheCurrentLocation(CameraPosition(
                                    zoom: 15,
                                    bearing: 40,
                                    target: viewModel.latLng!.value));
                              },
                            ),

                            viewModel.showCard.value?VetTile(
                              hideSidePadding: true,
                              model: viewModel.vetSelectedModel.value,onTap: (){
                              Get.toNamed(Routes.VET_PROFILE,arguments: {"id":
                              viewModel.vetSelectedModel.value.id
                              });
                            },):Container()
                          ],
                        )),
                    Positioned(
                      child: Column(
                        children: [
                          SearchWidget(searchController:viewModel.searchController,onChange: (value){

                            if (viewModel.debounce?.isActive ?? false) viewModel.debounce?.cancel();
                            viewModel.debounce = Timer(const Duration(milliseconds: 500), () {
                              viewModel.searchController.value.text = value;
                              viewModel.searchController.refresh();
                              viewModel.getVets(value);
                            });


                          },onTap: (){
                            Get.back();
                          },onClose: (){
                            viewModel.searchController.value.text = "";
                            viewModel.searchController.refresh();
                            Util.hideKeyBoard(context);
                            viewModel.arrOfVets.clear();
                          }),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount:viewModel.arrOfVets.length,
                            itemBuilder: (BuildContext context, int index) {

                              return GestureDetector(
                                onTap: (){
                                  Util.hideKeyBoard(context);
                                  viewModel.generateVets(viewModel.arrOfVets[index]);
                                  viewModel.searchController.value.text = "";
                                  viewModel.searchController.refresh();
                                  viewModel.arrOfVets.clear();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      height: 0.4,
                                      color: AppColors.grey.withOpacity(0.6),
                                    ),
                                    Container(

                                        color: AppColors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),

                                          child: Row(
                                            children: [
                                              viewModel.arrOfVets[index].userImage!=null?CircleImage(
                                                imageUrl: viewModel.arrOfVets[index].userImage!.mediaUrl!,
                                                size: 10.w,
                                                border: false,
                                              ):CircleImage(
                                                image: AppImages.user,
                                                size: 10.w,
                                                border: false,
                                              ),
                                              const SizedBox(width: AppDimen.contentPadding,),
                                              MyText(text: viewModel.arrOfVets[index].fullName!),
                                            ],
                                          ),
                                        )),

                                  ],
                                ),
                              );

                            },),
                        ],
                      ),
                    ),

                  ],
                )
              : viewModel.showLoader.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : NoLocationView(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
