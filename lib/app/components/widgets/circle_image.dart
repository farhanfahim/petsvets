import 'dart:io';

import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'common_image_view.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    this.border = true,
    this.size = 50,
    this.imageUrl,
    this.image ,
    this.fileImage,
  });

  final bool border;
  final double size;
  final String? imageUrl;
  final File? fileImage;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.textFieldBorderColor.withOpacity(0.5),
          border: Border.all(color: border?AppColors.red:AppColors.transparent,width: 1),
        borderRadius: BorderRadius.all(Radius.circular(size)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: CommonImageView(
          imagePath: image,
          url: imageUrl,
          placeHolder: AppImages.user,
          file: fileImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
