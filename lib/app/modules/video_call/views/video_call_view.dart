import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/components/widgets/common_image_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../utils/argument_constants.dart';
import '../../../../utils/bottom_sheet_service.dart';
import '../../../../utils/constants.dart';
import '../../../components/widgets/app_status_bar.dart';
import '../../../data/enums/page_type.dart';
import '../view_model/video_call_view_model.dart';

class VideoCallView extends StatelessWidget {
  final VideoCallViewModel viewModel = Get.put(VideoCallViewModel());

  VideoCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBar.getCallStatusBar(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      viewModel.data[ArgumentConstants.pageType] == PageType.video
                          ? CommonImageView(
                              imagePath: viewModel.role.value == Constants.roleVet? AppImages.vetVideoCallBg:AppImages.petVideoCallBg,
                              height: 100.h,
                              width: 100.w,
                            )
                          : CommonImageView(
                        imagePath: AppImages.calling,
                        height: 100.h,
                        width: 100.w,
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BottomSheetService.showConfirmationDialog(
                              title: "end_call",
                              content: "are_you_sure_want_to_end_call",
                              leftButtonText: "no",
                              rightButtonText: "yes,end",
                              onAgree: () async {
                                Get.back();
                                Get.back();
                              },
                            );
                          },
                          child: Container(
                            width: 100.w,
                            height: 20.h,
                            color: AppColors.transparent,
                          )
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
