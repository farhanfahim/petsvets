import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../data/models/vet_response_model.dart';
import '../../../../repository/pet_home_repository.dart';
import '../../no_location/views/no_location_view.dart';
import '../view_model/home_view_model.dart';
import '../widgets/map_button_widget.dart';
import '../widgets/map_header_view_widget.dart';
import '../widgets/vet_tile.dart';



class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  HomeViewModel viewModel = Get.put(HomeViewModel(repository: Get.find<PetHomeRepository>()));

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.backgroundColor,
        showAppBar: false,
        hasBackButton: false.obs,
        horizontalPadding: false,
        verticalPadding: false,
        child: Obx(
              () => viewModel.hasPermission.value
              ? Stack(
            children: [
              Obx(() => !viewModel.showLoader.value
                  ? viewModel.isMapVisible.value
                  ?   GoogleMap(
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
                  : RefreshIndicator(
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
                    noItemsFoundIndicatorBuilder: (context) =>
                        SizedBox(
                          height: 70.h,
                          child: Center(
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
                        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
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
                      Visibility(
                        visible: viewModel.isMapVisible.value,
                        child: MapButtonWidget(
                          image: AppImages.gpsDark,
                          onTap: () {
                            viewModel.toTheCurrentLocation(CameraPosition(
                                zoom: 15,
                                bearing: 40,
                                target: viewModel.latLng!.value));
                          },
                        ),
                      ),
                      MapButtonWidget(
                        title: viewModel.isMapVisible.value
                            ? "view_list".tr
                            : "map_view".tr,
                        image: viewModel.isMapVisible.value
                            ? AppImages.menu
                            : AppImages.map,
                        onTap: () {
                          if (viewModel.isMapVisible.value) {
                            viewModel.isMapVisible.value = false;
                            viewModel.showCard.value = false;
                          } else {
                            viewModel.isMapVisible.value = true;
                            viewModel.showCard.value = false;
                          }

                        },
                      ),
                      viewModel.showCard.value?VetTile(
                        hideSidePadding: true,
                        model: viewModel.selectedIndex!=null?viewModel.arrOfNearbyVets[viewModel.selectedIndex!.value]:viewModel.arrOfNearbyVets.first,onTap: (){
                        Get.toNamed(Routes.VET_PROFILE,arguments: {"id":
                        viewModel.arrOfNearbyVets[viewModel.selectedIndex!.value].id
                        });
                      },):Container()
                    ],
                  )),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Visibility(
                  visible: viewModel.isMapVisible.value,
                  child: Obx(() => MapHeaderViewWidget(
                    title: viewModel.currentAddress.value,
                    secondaryTitle: "show_other".tr,
                    image: AppImages.nearByCircle,
                    onTap: () {
                      Get.toNamed(Routes.OTHER_VET);
                    },
                  ),)
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

