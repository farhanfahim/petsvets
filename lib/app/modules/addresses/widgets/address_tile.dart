import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
import '../../../data/models/address_response_model.dart';

class AddressTile extends StatelessWidget {

  AddressData? model;
  Function() onTap;
  AddressTile({required this.onTap,this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
        color: AppColors.white,

        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:2.0),
                  child: CommonImageView(
                    imagePath: AppImages.addressLocation,
                    width: 3.w,
                  ),
                ),
                SizedBox(width: 1.h,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: MyText(
                            text: model!.address!,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.black,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 1.h,),
                        Obx(() => Visibility(
                          visible: model!.isSelected!.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color:  AppColors.gray600.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(AppDimen.radius),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: AppDimen.verticalPadding,horizontal: AppDimen.horizontalSpacing),
                            child: Center(
                              child: MyText(
                                text: "default".tr,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray600,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )),

                      ],
                    ),
                    const SizedBox(height: 4,),
                    Visibility(
                      visible: model!.city! == "-"?false:true,
                      child: MyText(
                        text: model!.city!,
                        maxLines: 3,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),),
                SizedBox(width: 1.h,),
                GestureDetector(
                  onTap: onTap,
                  child: const CommonImageView(
                    svgPath: AppImages.dotMenu,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 15),
              width: double.maxFinite,
              height: 0.4,
              color: AppColors.grey.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}