import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/app/data/enums/image_type.dart';
import 'package:petsvet_connect/app/data/models/Attachments.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'MyText.dart';
import 'common_image_view.dart';

class MediaTile extends StatelessWidget {
  final Attachments? data;
  final bool? showClose;
  final Function()? onCloseTap;

  const MediaTile(
      {super.key, required this.data, this.onCloseTap, this.showClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            Util.showToast("will be handled in beta phase");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data!.imageType == ImageType.image
                  ? data!.isNetwork==false?CommonImageView(
                      url: showClose! ? null : data!.url!,
                      file: File(data!.url!),
                      fit: BoxFit.cover,
                      height: 125,
                      width: double.maxFinite,
                    ):CommonImageView(
                      url: showClose! ? null : data!.url!,
                      fit: BoxFit.cover,

                      height: 125,
                      width: double.maxFinite,
                    ) : Container(
                      height: 125,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: AppColors.fieldsBgColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 35),
                      child: CommonImageView(
                        imagePath: data!.url!.contains("doc") || data!.url!.contains("docx")
                            ? AppImages.word
                                : data!.url!.contains("pdf")
                            ? AppImages.pdf
                            :AppImages.file,
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              MyText(
                text: data!.name!,
                maxLines: 1,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              MyText(
                text: "${"size".tr}4 MB",
                maxLines: 1,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onCloseTap,
            child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: CommonImageView(
                      svgPath: AppImages.close,
                    ))),
          ),
        )
      ],
    );
    ;
  }
}
