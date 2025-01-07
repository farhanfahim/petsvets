import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/modules/pet_module/medical_record/views/medical_record_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_appointment_detail/widgets/medical_record_tile.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../utils/dimens.dart';
class AppointmentMedicalRecordWidget extends StatelessWidget {

  const AppointmentMedicalRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top:AppDimen.contentPadding),
      padding: const EdgeInsets.all(AppDimen.allPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "medical_records".tr,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  fontSize: 16,
                ),

                SizedBox(height: AppDimen.verticalSpacing.w,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return   MedicalRecordTile(isLast: index==1,onTap: (){
                      Util.showToast("Will be handled in beta phase");
                    },);
                  },
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}