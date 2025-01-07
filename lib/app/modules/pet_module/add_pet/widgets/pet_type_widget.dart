import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:petsvet_connect/app/data/models/dummy_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../data/models/pet_response_model.dart';
import '../../../../data/models/pet_type_model.dart';

class PetTypeWidget extends StatelessWidget {

  const PetTypeWidget(this.model, this.onTap,{super.key});
  final Data model;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(() => GestureDetector(
        onTap:onTap,
        child: Container(
          decoration: BoxDecoration(
            color: model.isSelected!.value?AppColors.lightBlue:AppColors.backgroundColor,
            border: Border.all(color: model.isSelected!.value?AppColors.primaryColor:AppColors.gray600.withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(AppDimen.borderRadius),
            ),
          ),
          padding: const EdgeInsets.all(AppDimen.allPadding),
          child: MyText(
            text: model.name!,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
          ),
        ),
      ),)
    );
  }
}