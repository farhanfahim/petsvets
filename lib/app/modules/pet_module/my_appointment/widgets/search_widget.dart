import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_search_textfield.dart';

class SearchWidget extends StatelessWidget {

  SearchWidget({this.focusNode,this.onTapSuffix,this.onChange,this.showPadding = true,this.showClose =false,this.color=AppColors.white,this.showFilter=false,this.searchController, this.onTap,this.onTapClose,super.key});
  final Rx<TextEditingController>? searchController;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function()? onTapClose;
  final Function()? onTapSuffix;
  final Function(String)? onChange;
  bool showPadding;
  bool showFilter;
  bool showClose;
  Color? color;
  @override
  Widget build(BuildContext context) {

    return  Container(
      color: color,

      child: Column(
        children: [
          Container(
            padding:  EdgeInsets.only(left:showPadding?AppDimen.allPadding:0,right:showPadding?AppDimen.allPadding:0,bottom:AppDimen.allPadding),
            child: Row(
              children: [

                Visibility(
                  visible: showClose,
                  child: Row(
                    children: [

                      GestureDetector(
                        onTap: onTapClose,
                        child: const  CommonImageView(
                          svgPath: AppImages.close,
                          width: 16,
                        ),
                      ),
                      const SizedBox(width: AppDimen.allPadding,),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomSearchTextField(
                    controller: searchController!.value,
                    hintText: "search".tr,
                    prefixWidget: const Padding(
                      padding: EdgeInsets.only(left: 10.0,top: 4,bottom: 4),
                      child: CommonImageView(
                        svgPath:AppImages.searchIcon,
                        width: 20,
                      ),
                    ),
                    focusNode: focusNode,
                    sufixIconOnTap: onTapSuffix,
                    lableFontSize: AppFontSize.small2,
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
                Visibility(
                  visible: showFilter,
                  child: Row(
                    children: [
                      const SizedBox(width: AppDimen.allPadding,),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.all( 8.0),
                          decoration: const BoxDecoration(
                            color:  AppColors.fieldsBgColor,
                            borderRadius: BorderRadius.all(Radius.circular(AppDimen.borderRadius),
                            ),
                          ),

                          child: const CommonImageView(
                            svgPath:AppImages.filter,
                            width: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}