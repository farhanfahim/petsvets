import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
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

  final PetTypeModel? model;
  final bool? isLast;
  final Function()? onTap;
  final Function()? onTapSelectBreed;
  final Function()? onTapAddNew;

  PetInfoWidget({this.isLast,this.model, this.onTap,this.onTapSelectBreed,this.onTapAddNew});

  @override
  Widget build(BuildContext context) {

    return  Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: AppDimen.formSpacing),
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimen.verticalSpacing.h),
          CustomTextField(
            hintText: model!.title,
            label: "pet".tr,
            readOnly: true,
            keyboardType: TextInputType.name,
            limit: Constants.fullNameLimit,
          ),
          SizedBox(height: AppDimen.verticalSpacing.h),
          Obx(() => CustomTextField(
            controller: TextEditingController(text: model!.breed!.value),
            hintText: "select_breed".tr,
            label: "breed".tr,
            readOnly: true,
            onTap: onTapSelectBreed,
            icon: AppImages.arrowDown,
            keyboardType: TextInputType.name,
            limit: Constants.fullNameLimit,
          ),),
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