import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/shimmers/page_shimmer.dart';
import 'package:petsvet_connect/app/repository/auth_repository.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../view_model/page_view_model.dart';
import 'package:flutter_html/flutter_html.dart';

class PageView extends StatelessWidget {

  PageViewModel viewModel = Get.put(PageViewModel(repository: Get.find<AuthRepository>()));

  PageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      hasBackButton: true.obs,
      titleColor: AppColors.blackColor,
      appBarBackgroundColor: AppColors.white,
      backIconColor: AppColors.blackColor,
      screenName: viewModel.getPageTitle(),
      backgroundColor: AppColors.white,
      centerTitle: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding),
          child: Obx(() => !(viewModel.isDataLoading.value) ? Html(
            data: viewModel.pageModel.value.content!.trim(),

          ) : const PageShimmer())
        ),
      ),
    );
  }
}
