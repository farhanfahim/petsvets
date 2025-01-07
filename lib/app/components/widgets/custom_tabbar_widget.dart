import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.selectedColor,
  }) : super(key: key);

  final TabController controller;
  final List<Widget> tabs;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.black,
        indicatorColor: AppColors.red,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
        labelStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
        unselectedLabelColor:AppColors.gray600.withOpacity(0.6),
        tabs: tabs,
      ),
    );
  }
}
