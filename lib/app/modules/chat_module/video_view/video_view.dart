import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/chat_module/video_view/view_model/video_view_controller.dart';
import 'package:petsvet_connect/app/modules/chat_module/video_view/widget/my_video_player.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/custom_back_button.dart';


class VideoView extends StatelessWidget {
  VideoViewModel controller = Get.put(VideoViewModel());

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
                Get.back();
              } else if (details.delta.dy < -sensitivity) {
                Get.back();
              }
            },
            child:  Obx(() => MyVideoPlayer(mediaUrl: controller.url.value)),
          ),
        )
    );
  }
}
