import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/Util.dart';
import '../../../../utils/app_font_size.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_fonts.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../components/widgets/custom_divider.dart';
import '../../../data/models/local_location.dart';
import '../../../repository/address_repository.dart';
import '../../pet_module/home/widgets/map_button_widget.dart';
import '../../pet_module/vet_search/widgets/search_widget.dart';
import '../view_model/add_location_picker_view_model.dart';
import '../widgets/location_items.dart';

class AddLocationPickerView extends GetView<AddLocationPickerViewModel> {

  AddLocationPickerViewModel viewModel = Get.put(AddLocationPickerViewModel(repository: Get.find<AddressRepository>()));

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.white,
        showAppBar: false,
        horizontalPadding: false,
        verticalPadding: false,
        hasBackButton: false.obs,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimen.pagesVerticalPadding,),
                  Container(

                    color: AppColors.white,
                    padding: const EdgeInsets.only(left:AppDimen.pagesHorizontalPadding,right: AppDimen.pagesHorizontalPadding,bottom: 10),

                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: CommonImageView(
                              svgPath:AppImages.close,
                              width: 15,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(() => GooglePlaceAutoCompleteTextField(
                            textEditingController:  controller.searchController.value,
                            focusNode: controller.searchNode,
                            googleAPIKey:Constants.mapApiKey,
                            boxDecoration:BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            textStyle: const TextStyle(
                                fontFamily: AppFonts.fontMulish,
                                fontSize: 14,
                                color: AppColors.primaryColor),
                            inputDecoration:  InputDecoration(

                              fillColor: AppColors.fieldsBgColor,
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
                                borderSide: const BorderSide(width: 1.0, color: AppColors.error),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
                                borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
                                borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
                                borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimen.textFieldBorderRadius),
                                borderSide: const BorderSide(width: 1.0, color: AppColors.textFieldBorderColor),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 15.0,top: 12,bottom: 12,right: 8),
                                child: CommonImageView(
                                  svgPath:AppImages.searchIcon,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
                              hintText: "search".tr,
                              filled: true,

                              hintStyle: TextStyle(
                                fontSize: AppFontSize.extraSmall,
                                color: AppColors.grey,
                                fontFamily: AppFonts.fontMulish,
                                fontWeight: FontWeight.w400,
                              ),),
                            debounceTime: 400,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) async {
                              print("farhan");

                              controller.predication.value = prediction;
                              controller.lat.value = double.parse(prediction.lat.toString());
                              controller.lng.value = double.parse(prediction.lng.toString());
                              controller.lng.refresh();
                              controller.lat.refresh();

                              controller.selectLocation(LocalLocation(
                                  type: "Point",
                                  coordinates: [
                                    controller.lat.value,
                                    controller.lng.value
                                  ],
                                  radius: "50",
                                  address: controller.predication.value!.structuredFormatting!.mainText,
                                  city: controller.predication.value!.structuredFormatting!.secondaryText!=null?controller.predication.value!.structuredFormatting!.secondaryText!:""
                              ));

                              controller.moveToCameraLocation(latLng: LatLng(double.parse(controller.lat.value.toString()),
                                  double.parse(controller.lng.value.toString())));
                              controller.searchNode.unfocus();
                              Util.hideKeyBoard(context);

                            },
                            itemClick: (Prediction prediction) {
                              controller.searchController.value.text = prediction.description ?? "";
                              controller.searchController.value.selection = TextSelection.fromPosition(
                                  TextPosition(offset: prediction.description?.length ?? 0));
                              if(controller.searchController.value.text.isNotEmpty){
                                controller.showCancelBtn.value = true;
                              }else{
                                controller.showCancelBtn.value = false;
                              }
                              controller.searchNode.unfocus();
                              Util.hideKeyBoard(context);


                            },
                            itemBuilder: (context, index, Prediction prediction) {
                              return LocationSearchItem(
                                location: prediction,
                              );
                            },
                            isCrossBtnShown: true,
                          )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 0.4,
                    color: AppColors.grey.withOpacity(0.6),
                  ),

                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Positioned.fill(
                  child: Obx(() => GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(28.4212, 70.2989),
                      zoom: 16.0,
                    ),
                    markers: Set<Marker>.of(controller.allMarkers),
                    rotateGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,

                    mapType: MapType.normal,
                  ),)
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width:42,
                        margin: const EdgeInsets.only(right: 10,bottom: 10),
                        child: MapButtonWidget(
                          image: AppImages.gpsDark,
                          onTap: () {
                            controller. initCurrentLocation();
                            },
                        ),
                      ),
                      Obx(() {
                        var loc = controller.location.value;
                        return loc != null
                            ? Container(
                          width: double.maxFinite,
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1.h,),
                              MyText(text: "your_location".tr, fontSize: 14,fontWeight:FontWeight.w600, color: AppColors.black,),
                              SizedBox(height: 1.h,),
                              Row(children: [
                                const CommonImageView(
                                  svgPath: AppImages.pin,
                                ),
                                SizedBox(width: 1.h,),
                                Expanded(
                                  child: MyText(text: loc.address!, fontSize: 12,fontWeight:FontWeight.w400, color: AppColors.black,),
                                ),
                              ],),
                              SizedBox(height: 2.h),
                              CustomButton(
                                label: 'confirm_location'.tr,
                                textColor: AppColors.white,
                                fontWeight: FontWeight.w700,
                                controller: viewModel.btnController,
                                onPressed: () {
                                  if(viewModel.data){
                                    viewModel.addAddressAPI(loc);
                                  }else{
                                    Get.back(result: loc);
                                  }

                                },

                              ),
                              SizedBox(height: 2.h),
                            ],
                          ),)
                            : const SizedBox.shrink();
                      }),
                    ],
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
