import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/widgets/app_status_bar.dart';
import 'package:petsvet_connect/app/modules/auth/splash/view_model/splash_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../widgets/version_number.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel viewModel = Get.put(SplashViewModel());

  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBar.splashStatusBar(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: CommonImageView(
                  imagePath: AppImages.splashLogo,
                  width: 45.w,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Obx(
                  () => VersionNumber(
                version: viewModel.packageInfo.value?.version ?? "",
              ),
            )
          ],
        ),
      ),
    );
  }
}
