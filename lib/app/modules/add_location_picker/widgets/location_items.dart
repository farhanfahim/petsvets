import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/custom_button.dart';
import '../../../data/models/local_location.dart';
import '../../../data/models/location.dart';

class LocationSearchItem extends StatelessWidget {

  final Prediction location;
  const LocationSearchItem({Key? key,required this.location,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Material(
      color: AppColors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10,),
              const Padding(
                padding: EdgeInsets.only(top: 3.0),
                child: CommonImageView(
                  imagePath: AppImages.addressLocation,
                  width: 10,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: location.structuredFormatting!.mainText!,fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.black,),
                    Visibility(
                        visible: location.structuredFormatting!.secondaryText!=null,
                        child: MyText(text: location.structuredFormatting!.secondaryText!=null?location.structuredFormatting!.secondaryText!:"", fontSize: 12,fontWeight:FontWeight.w400, color: AppColors.gray600,)),

                  ],),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom:10,
                left:AppDimen.pagesVerticalPadding,
                right:AppDimen.pagesVerticalPadding,
                top:10
            ),
            child: Container(
              width: double.maxFinite,
              height: 0.4,
              color: AppColors.grey.withOpacity(0.4),
            ),
          ),
        ],
      ),
    ),);
  }
}



