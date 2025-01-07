import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../components/resources/app_colors.dart';
import '../../../../../components/resources/app_images.dart';
import '../../../../../components/widgets/circular_button.dart';
import '../../../../../components/widgets/common_image_view.dart';
import '../../../../../components/widgets/custom_timer.dart';
import '../controllers/voice_message_controller.dart';

class VoiceMessageView extends StatelessWidget {
  final VoiceMessageController controller = Get.put(VoiceMessageController());

   VoiceMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final double iconsize = 20;
    final double diameter = 35;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(builder: (con, cons) {
            var size = media;
            int count = (size.width /120).ceil();
            return SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(count, (index) {
                  return buildWave(
                    120,
                  );
                }),
              ),
            );
          }),
          Center(
            child: Obx(() => CustomTimer(
                seconds: controller.seconds.value,
                fontSize: 12,
                color: Colors.black)),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.5)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonImageView(
                  svgPath: AppImages.deleteIcon,
                  height: iconsize,
                  width: iconsize,
                  onTap: () {
                    controller.stopRecording(isDeleteHit: true);
                    Get.back();
                  },
                ),
                Obx(
                  () => CircularButton(
                    diameter: 64,
                    icon: (!controller.isPaused.value)
                        ? AppImages.pauseIcon
                        : AppImages.playIcon,
                    isSvg: true,
                    onTap: () {
                      if (!controller.isPaused.value) {
                        controller.pauseRecording();
                      } else {
                        controller.resumeRecording();
                      }
                    },
                  ),
                ),
                CommonImageView(
                  svgPath: AppImages.snd,
                  height: iconsize,
                  width: iconsize,
                  onTap: () {
                    controller.stopRecording();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildWave(
    double width,
  ) {
    return SizedBox(
      //color: Colors.green,
      width: width,
      child: Lottie.asset(AppImages.soundWave,
          alignment: Alignment.topLeft,
          controller: controller.animController, //height: 120,
          fit: BoxFit.fill),
    );
  }
}
