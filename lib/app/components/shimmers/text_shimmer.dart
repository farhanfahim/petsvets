import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../resources/app_colors.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
          child: const Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 100, height: 15.0, child: Skeleton()),
                  ],
                ),
              ),


            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 0.5,
          color: AppColors.grey.withOpacity(0.6),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
          child: const Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 150, height: 15.0, child: Skeleton()),
                  ],
                ),
              ),


            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 0.5,
          color: AppColors.grey.withOpacity(0.6),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
          child: const Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 120, height: 15.0, child: Skeleton()),
                  ],
                ),
              ),


            ],
          ),
        ),
      ],
    );
  }
}
