import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'circle_image.dart';
import 'common_image_view.dart';

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({
    super.key,
    this.onTap,
    this.fileImage,
    this.networkImage,
    this.image,
    this.color,
    this.border = true,
    this.size = 18,
  });

  final void Function()? onTap;
  final File? fileImage;
  final String? networkImage;
  final String? image;
  final Color? color;
  final bool border;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.Circle,
        padding: EdgeInsets.zero,
        dashPattern: const [5, 5],
        color: border ? AppColors.grey.withOpacity(0.6) : AppColors.white,
        strokeWidth: border ? 1 : -1,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          height: size.w,
          width: size.w,
          child: Stack(
            children: [
              CircleImage(
                imageUrl: networkImage,
                fileImage: fileImage,
                image: image,
                size: size.w,
                border: false,
              ),
              Align(
                alignment: Alignment.center,
                child: CommonImageView(
                  svgPath: AppImages.cameraImg,
                  color: color,
                  height: 3.h,
                  width: 3.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
