import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/custom_button.dart';
import '../view_model/prescirbe_medicine_view_model.dart';
import '../widgets/prescribe_tile.dart';

class PrescribeMedicineView extends StatelessWidget {
  final PrescribeMedicineViewModel viewModel = Get.put(PrescribeMedicineViewModel());

  PrescribeMedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.white,
        showAppBar: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        resizeToAvoidBottomInset: true,
        screenName: "prescribe_medicine".tr,
        child: AbsorbPointer(
          absorbing: viewModel.absorb.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Obx(() => Expanded(child: SingleChildScrollView(
                controller: viewModel.scrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: viewModel.arrOfPrescription.length,

                  itemBuilder: (BuildContext context, int index) {
                    return PrescribeTile(
                        isFirst: index ==0,
                        pos: index,
                        isLast: viewModel.arrOfPrescription.length-1 == index,
                        model:viewModel.arrOfPrescription[index]);
                  },
                ),
              ),)),
              const SizedBox(height: AppDimen.pagesVerticalPadding,),
              Container(
                color: AppColors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimen.horizontalPadding.w,vertical: AppDimen.pagesVerticalPaddingNew),

                child: CustomButton(
                  label: 'prescribe'.tr,
                  borderColor: AppColors.red,
                  color: AppColors.red,
                  textColor: AppColors.white,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    viewModel.onTapPrescribe();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
