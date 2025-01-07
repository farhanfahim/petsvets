import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import '../../../../../../utils/dimens.dart';
import '../../../../components/widgets/text_field_label.dart';

class AppointmentGeneralWidget extends StatelessWidget {

  String? title;
  bool? isMandatory;
  bool? isBold;
  Widget? widget;
  Widget? mainWidget;
  AppointmentGeneralWidget({super.key, this.isBold=false,this.title = "",this.isMandatory = false,this.widget,this.mainWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      padding: const EdgeInsets.only(top: AppDimen.pagesVerticalPadding,bottom: AppDimen.pagesVerticalPaddingNew),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFieldLabel(label: title ?? "",mandatory: isMandatory!,isBold:isBold!)
                ),
                widget??Container()

              ],
            ),
          ),
          mainWidget??Container()
        ],
      ),
    );
  }
}