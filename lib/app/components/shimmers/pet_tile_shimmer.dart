import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../resources/app_colors.dart';

class PetTileShimmer extends StatelessWidget {
  const PetTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(color: AppColors.gray600.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(AppDimen.borderRadius),
              ),
            ),
            padding: const EdgeInsets.all(AppDimen.allPadding),
            child:  SizedBox(width: 10.w, height: 15.0, child: Skeleton()),
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(color: AppColors.gray600.withOpacity(0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(AppDimen.borderRadius),
              ),
            ),
            padding: const EdgeInsets.all(AppDimen.allPadding),
            child:  SizedBox(width: 10.w, height: 15.0, child: Skeleton()),
          ),
        ),
      ],
    );
  }
}
