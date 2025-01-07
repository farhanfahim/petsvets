import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/widgets/Skeleton.dart';

class PageShimmer extends StatelessWidget {
  const PageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        SizedBox(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(width: 200.0, height: 20.0, child: Skeleton()),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(width: 100.0, height: 20.0, child: Skeleton()),
      ],
    );
  }
}
