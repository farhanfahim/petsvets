import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/Skeleton.dart';
import '../../../../components/widgets/circle_image.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_audio_player.dart';
import '../../../../data/models/chat_room_model.dart';
import '../../../../firestore/chat_strings.dart';
import '../../../../firestore/chatting_model.dart';
import '../../../../routes/app_pages.dart';

// ignore: must_be_immutable
class ChatTileWidget extends StatelessWidget {
  ChatTileWidget(this.data,this.myUserImage,this.userImage);
  ChattingModel data;
  String myUserImage;
  String userImage;

  @override
  Widget build(BuildContext context) {
    bool isSender = false;
    isSender = data.userId == data.senderId;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          if (!isSender)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(100),
                    child: userImage.isNotEmpty?CircleImage(
                      imageUrl: userImage,
                      size: 8.w,
                      border: false,
                    ):CircleImage(
                      image: AppImages.user,
                      size: 8.w,
                      border: false,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 0
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data.type==ChatStrings.messageTypeText?Material(
                          elevation: 0,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(50)),
                          color: AppColors.chatReceiverColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                            child:MyText(
                              text:data.text,
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                        )
                            :data.type==ChatStrings.messageTypeImage || data.type==ChatStrings.messageTypeVideo?Column(
                          children: [
                            Visibility(
                              visible: data.text.isNotEmpty,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(20)),
                                    color: AppColors.chatSenderColor2
                                ),

                                child: Container(
                                  width: 75.w,
                                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                  child: MyText(
                                    text:data.text,
                                    fontSize: 13,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(data.image != ""){
                                  if (data.type == ChatStrings.messageTypeImage) {
                                    if (data.image != "") {
                                      Map<String, dynamic> map = {ChatStrings.imageUrl: data.image};
                                      Get.toNamed(Routes.IMAGE_VIEW,arguments: map);
                                    }
                                  } else if (data.type == ChatStrings.messageTypeVideo) {
                                    Map<String, dynamic> map = {ChatStrings.videoUrl: data.video};
                                    Get.toNamed(Routes.VIDEO_VIEW,arguments: map);
                                  }
                                }
                              },
                              child:   data.image == "" ? ClipRRect(
                                borderRadius:
                                BorderRadius.only(
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
                                    topLeft: Radius.circular(data.text.isNotEmpty?0:20),
                                    topRight: Radius.circular(data.text.isNotEmpty?0:20)),
                                child: Skeleton(
                                  width: 75.w,
                                  height: 35.w,
                                ),
                              ):Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(
                                        bottomLeft: const Radius.circular(20),
                                        bottomRight: const Radius.circular(20),
                                        topLeft: Radius.circular(data.text.isNotEmpty?0:20),
                                        topRight: Radius.circular(data.text.isNotEmpty?0:20)),
                                    child: CommonImageView(
                                        width: 75.w,
                                        height: 35.w,
                                        fit: BoxFit.cover,
                                        url: data.image),
                                  ),
                                  Visibility(
                                    visible: data.type==ChatStrings.messageTypeVideo,
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColor.withOpacity(0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CommonImageView(
                                          svgPath: AppImages.playIcon,color: AppColors.white,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                            :data.type==ChatStrings.messageTypeAudio?Column(
                          children: [
                            data.audio == ""?Skeleton(width: 75.w,height: 20.w,cornerRadius: 15,):AudioPlayerWidget(mediaUrl: data.audio,
                              onClose: (){},
                            )
                          ],
                        )
                            :data.type==ChatStrings.messageTypeFile?InkWell(

                          onTap: () async {
                            var parts = data.file.split(':');
                            if (!await launchUrl(
                              Uri(scheme: 'https', path: parts[1]),
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch ${Uri(scheme: 'https', path: parts[1])}');
                            }
                          },
                          child:   ClipRRect(
                            borderRadius:
                            const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular( 0),
                                topRight: Radius.circular( 20)),
                            child: Container(
                              color: AppColors.chatSenderColor2,
                              padding: const EdgeInsets.all(AppDimen.pagesVerticalPaddingNew),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  data.file == ""
                                      ? const Skeleton(
                                    width: 24,
                                    height: 24,
                                    cornerRadius: 20,
                                  ):CommonImageView(
                                    width: 24,
                                    height: 24,
                                    imagePath: data.text.contains("doc") || data.text.contains("docx")
                                        ? AppImages.word
                                        : data.text.contains("xlsx") || data.text.contains("xls")
                                        ? AppImages.excel
                                        : data.text.contains("pdf")
                                        ? AppImages.pdf
                                        :AppImages.file,
                                  ),

                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: data.file == ""?const Skeleton(
                                      width: 100,
                                      height: 20,
                                      cornerRadius: 20,
                                    ):MyText(
                                      text:data.text,
                                      fontSize: 13,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(width: AppDimen.horizontalSpacing,),
                                ],
                              ),
                            ),
                          ),
                        )
                            :Container(),
                        Padding(
                          padding: const EdgeInsets.only(left:5,bottom: 10,top: 5),
                          child: MyText(
                              text:getTime(((data.time as Timestamp)).toDate()),
                              fontSize: 12,
                              color:AppColors.gray600

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

          if (isSender)
            Row(
              mainAxisAlignment:MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,vertical: 3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        data.type == ChatStrings.messageTypeText?Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(0)),
                              color: AppColors.chatSenderColor1
                          ),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                            child: MyText(
                              text:data.text,
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                        )
                            :data.type==ChatStrings.messageTypeImage || data.type==ChatStrings.messageTypeVideo?Column(
                          children: [
                            Visibility(
                              visible: data.text.isNotEmpty,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(0)),
                                    color: AppColors.chatSenderColor2
                                ),

                                child: Container(
                                  width: 75.w,
                                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                  child: MyText(
                                    text:data.text,
                                    fontSize: 13,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child:   data.image == "" ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.only(
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
                                    topLeft: Radius.circular(data.text.isNotEmpty?0:20),
                                    topRight: Radius.circular(data.text.isNotEmpty?0:20)),
                                    child: Skeleton(
                                      width: 75.w,
                                      height: 35.w,
                                    ),
                                  ):Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.only(
                                        bottomLeft: const Radius.circular(20),
                                        bottomRight: const Radius.circular(20),
                                        topLeft: Radius.circular(data.text.isNotEmpty?0:20),
                                        topRight: Radius.circular(data.text.isNotEmpty?0:20)),
                                        child: CommonImageView(
                                      width: 75.w,
                                      height: 35.w,
                                      fit: BoxFit.cover,
                                      url: data.image),
                                      ),
                                      Visibility(
                                        visible: data.type==ChatStrings.messageTypeImage,
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor.withOpacity(0.5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CommonImageView(
                                              svgPath: AppImages.playIcon,color: AppColors.white,),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ],
                        )
                            :data.type==ChatStrings.messageTypeAudio?Column(
                          children: [
                            data.audio == ""?Skeleton(width: 75.w,height: 20.w,cornerRadius: 15,):AudioPlayerWidget(mediaUrl: data.audio,
                              onClose: (){},
                            )
                          ],
                        )
                            :data.type==ChatStrings.messageTypeFile?InkWell(
                          onTap: () async {
                            var parts = data.file.split(':');
                            if (!await launchUrl(
                              Uri(scheme: 'https', path: parts[1]),
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch ${Uri(scheme: 'https', path: parts[1])}');
                            }
                          },
                          child:   ClipRRect(
                            borderRadius:
                            const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                topLeft: Radius.circular( 20),
                                topRight: Radius.circular( 0)),
                            child: Container(
                              color: AppColors.chatSenderColor2,
                              padding: const EdgeInsets.all(AppDimen.pagesVerticalPaddingNew),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  data.file == ""
                                      ? const Skeleton(
                                    width: 24,
                                    height: 24,
                                    cornerRadius: 20,
                                  ):CommonImageView(
                                    width: 24,
                                    height: 24,
                                    imagePath: data.text.contains("doc") || data.text.contains("docx")
                                        ? AppImages.word
                                        : data.text.contains("xlsx") || data.text.contains("xls")
                                        ? AppImages.excel
                                        : data.text.contains("pdf")
                                        ? AppImages.pdf
                                        :AppImages.file,
                                  ),

                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: data.file == ""?const Skeleton(
                                      width: 100,
                                      height: 20,
                                      cornerRadius: 20,
                                    ):MyText(
                                      text:data.text,
                                      fontSize: 13,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(width: AppDimen.horizontalSpacing,),
                                ],
                              ),
                            ),
                          ),
                        )
                            :Container(),
                        Padding(
                          padding: const EdgeInsets.only(right:5,bottom: 10,top: 5),
                          child: MyText(
                              text:data.time!=null?getTime(((data.time as Timestamp)).toDate()):"",
                              fontSize: 12,
                              color:AppColors.gray600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: myUserImage.isNotEmpty?CircleImage(
                    imageUrl: myUserImage,
                    size: 8.w,
                    border: false,
                  ):CircleImage(
                    image: AppImages.user,
                    size: 8.w,
                    border: false,
                  ),
                ),

              ],
            )


        ],
      ),
    );
  }
  static String getTime(DateTime dateTime) {
    var xxx = DateFormat("hh:mm a").format(dateTime);
    return xxx.toString();
  }
}
