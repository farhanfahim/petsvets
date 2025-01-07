import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/modules/chat_module/image_view/view_model/image_view_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/widgets/common_image_view.dart';
import '../../../components/widgets/custom_back_button.dart';


class ImageView extends StatelessWidget {

  final ImageViewModel viewModel = Get.put(ImageViewModel());

  ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            scrolledUnderElevation:0,
            backgroundColor: Colors.black,
            clipBehavior: Clip.none,
            leadingWidth: 25.w,

            leading:Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 2.0),
              child: CustomBackButton(
                backTitle: "txt_back".tr,
                backImage: AppImages.backIcon,
                onTap: (){
                  Get.back();
                },
                color: AppColors.white,
              ),
            )
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
              onVerticalDragUpdate: (details) {
                int sensitivity = 15;
                if (details.delta.dy > sensitivity) {
                  // Down Swipe
                  Navigator.pop(context);
                } else if (details.delta.dy < -sensitivity) {
                  // Up Swipe
                  Navigator.pop(context);
                }
              },
              child: Obx(() => Center(
                child: CommonImageView(
                  url: viewModel.imageUrl.value,
                ),
              ))
          ),
        )
    );
  }
}
