import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/app/modules/dashboard/view_model/dashboard_view_model.dart';

class CounterBadge extends StatelessWidget {
  RxInt? count = 0.obs;
  CounterBadge({ this.count,super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => count!.value == 0
          ? const SizedBox()
          : Container(
              decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.only(right: 10, top: 10),
              height: 15,
              width: 15,
              child: MyText(
                text: count!.value < 9 ? count!.value.toString() : "9+",
                color: AppColors.white,
                center: true,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
