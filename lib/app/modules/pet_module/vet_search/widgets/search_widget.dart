import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../../utils/Util.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_textfield.dart';

class SearchWidget extends StatelessWidget {

  const SearchWidget({this.searchController,this.onChange, this.onClose, this.onTap});
  final Rx<TextEditingController>? searchController;
  final Function()? onTap;
  final Function()? onClose;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 60,
      color: AppColors.white,
      padding: const EdgeInsets.only(left:AppDimen.pagesHorizontalPadding,right: AppDimen.pagesHorizontalPadding,bottom: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
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
            child: CustomTextField(
              controller: searchController!.value,
              hintText: "search".tr,
              prefixWidget: const Padding(
                padding: EdgeInsets.only(left: 10.0,top: 4,bottom: 4),
                child: CommonImageView(
                  svgPath:AppImages.searchIcon,
                  width: 24,
                ),
              ),
              sufixIconOnTap: onClose,
              suffixWidget: Obx(() => Visibility(
                visible: searchController!.value.text.isNotEmpty,
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0,top: 8,bottom: 8),
                  child: CommonImageView(
                    svgPath:AppImages.close,
                    width: 14,
                    color: AppColors.grey,
                  ),
                ),
              ),),
              onChanged: onChange,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.streetAddress,
              limit: Constants.fullNameLimit,
            ),
          ),
        ],
      ),
    );
  }
}