import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/widgets/MyText.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';

class CustomModelSheet extends StatelessWidget {
  CustomModelSheet({
    super.key,
    required this.title,
    required this.msg,
    this.msg2,
    this.onTap2,
    this.btnTxt1,
    this.btnTxt2,
    this.okBtnTxt,
    this.onTap1,
    this.onTapOk,
    this.onTapMsg2,
    this.showOkButton,
  });

  final String? title;
  final String? msg;
  final String? msg2;
  final String? btnTxt1;
  final String? btnTxt2;
  final String? okBtnTxt;
  final bool? showOkButton;
  final Function? onTap2;
  final Function? onTapMsg2;
  final Function? onTap1;
  final Function? onTapOk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.barrierColor.withOpacity(0.2),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        //color: AppColors.textPrimaryColor.withOpacity(0.3),
        child: Center(
          child: Container(
            width: 75.w,
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: MyText(
                  text: '$title',
                  fontSize: 19,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                )),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MyText(
                    text: '$msg',
                    fontSize: AppFontSize.extraSmall,
                    color: AppColors.blackColor,
                    center: true,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                msg2 == null
                    ? const Offstage()
                    : GestureDetector(
                        onTap: () {
                          onTapMsg2!();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: MyText(
                            text: '$msg2',
                            fontSize: AppFontSize.small,
                            color: AppColors.primaryColor,
                            center: true,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                SizedBox(height: 2.h),
                Container(
                  height: 1,
                  width: 100.w,
                  color: AppColors.dividerColor,
                ),
                showOkButton!
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                          onTapOk!();
                        },
                        child: SizedBox(
                          width: 60.w,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: MyText(
                                text: okBtnTxt!,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onTap1!();
                              Get.back();
                            },
                            child: SizedBox(
                                width: 30.w,
                                child: Center(
                                  child: MyText(
                                    text: btnTxt1!,
                                    fontSize: AppFontSize.small,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          // CustomDivider(),
                          Container(
                            width: 1,
                            height: 5.h,
                            color: AppColors.dividerColor,
                          ),

                          GestureDetector(
                            onTap: () {
                              onTap2!();
                            },
                            child: SizedBox(
                                width: 30.w,
                                child: Center(
                                  child: MyText(
                                    text: btnTxt2!,
                                    fontSize: AppFontSize.small,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
