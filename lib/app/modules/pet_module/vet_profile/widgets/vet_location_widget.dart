import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../data/models/vet_detail_model.dart';
import 'map_tile.dart';

class VetLocationWidget extends StatelessWidget {

  final VetDetailResponseModel? model;
  final String? address;
  const VetLocationWidget({this.model, this.address,super.key} );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top:AppDimen.allPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          MyText(
            text: "emergency_location".tr,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            fontSize: 16,
          ),
          const SizedBox(height: 5,),
          MapTileView(image:model!.userImage!=null?model!.userImage!.mediaUrl!:"",lat:model!.latitude!,lng:model!.longitude!,address:address!)

        ],
      ),
    );
  }
}