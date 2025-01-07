import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:petsvet_connect/app/data/models/pet_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../data/models/pet_type_model.dart';

class PetInfoWidget extends StatelessWidget {

  final String? petName;
  final Rx<String>? breed;
  final bool? isLast;
  final bool? isCustom;
  final Function()? onTap;
  final Function()? onTapSelectBreed;
  final Function()? onTapAddNew;
  final Function(String)? onChangeValue;

  PetInfoWidget({this.onChangeValue,this.isLast,this.isCustom,this.petName,this.breed, this.onTap,this.onTapSelectBreed,this.onTapAddNew});

  @override
  Widget build(BuildContext context) {

    return  Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: AppDimen.formSpacing,),
      padding: const EdgeInsets.only( left: AppDimen.pagesHorizontalPadding,right: AppDimen.pagesHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimen.verticalSpacing.h),
          CustomTextField(
            hintText: petName,
            label: "pet".tr,
            readOnly: true,
            keyboardType: TextInputType.name,
            limit: Constants.fullNameLimit,
          ),
          SizedBox(height: AppDimen.verticalSpacing.h),
        CustomTextField(
          controller: TextEditingController(text: breed!.value),
          hintText: isCustom ==false?"select_breed".tr:"enter_breed".tr,
          label: "breed".tr,
          onChanged: onChangeValue,
          readOnly: isCustom ==false?true:false,
          onTap: isCustom ==false?onTapSelectBreed:(){},
          icon: isCustom ==false?AppImages.arrowDown:null,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          limit: Constants.fullNameLimit,
        ),
         Visibility(
           visible: isLast!,
           child: Column(
             children: [
               SizedBox(height: AppDimen.verticalSpacing.h),
               GestureDetector(
                 onTap: onTapAddNew,
                 child: Row(
                   children: [
                     const CommonImageView(
                       svgPath: AppImages.imgPlus,
                     ),
                      MyText(text: "add_new".tr,color: AppColors.red,fontWeight: FontWeight.w700,fontSize: 14,),
                   ],
                 ),
               ),
             ],
           ),
         ),
          SizedBox(height: AppDimen.verticalSpacing.h),

        ],
      ),
    );
  }
}