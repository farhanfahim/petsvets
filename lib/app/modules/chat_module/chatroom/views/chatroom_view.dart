import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/firestore/chat_constants.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_images.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/common_image_view.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../firestore/chat_strings.dart';
import '../../../../firestore/chatting_model.dart';
import '../../voice_data/voice_pop_up/controllers/voice_message_controller.dart';
import '../../voice_data/voice_pop_up/views/voice_message_view.dart';
import '../view_model/chatroom_view_model.dart';
import '../widgets/attachment_dialog.dart';
import '../widgets/chat_tile_widget.dart';
import '../widgets/chatting_date_tile.dart';

class ChatRoomView extends StatelessWidget {
  final ChatRoomViewModel viewModel = Get.put(ChatRoomViewModel());

  ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        showAppBar: true,
        showHeader: false,
        hasBackButton: true.obs,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        resizeToAvoidBottomInset: true,
        screenName: viewModel.map[ChatConstants.threadName],
        actions: [
          GestureDetector(
            onTap: (){
              viewModel.onTapReport();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: AppDimen.pagesHorizontalPadding),
              child: CommonImageView(
                svgPath: AppImages.dotMenu,
              ),
            ),
          )
        ],
        child: Column(
          children: [
            Expanded(

              ///Chat list widget
              child: Obx(() => FutureBuilder<Stream<List<ChattingModel>>>(
                  future: viewModel.getChatMessages(),
                  builder: (context, messagesSnapshot) {
                    if (messagesSnapshot.hasData) {
                      return Obx(() => viewModel.chatList.isNotEmpty?StreamBuilder<List<ChattingModel>>(
                        stream: messagesSnapshot.requireData,
                        builder: (context, chatMessagesSnapshot) {

                            return  ListView(
                              controller: viewModel.scrollController,
                              reverse: true,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(4.0, 10, 4, 10),
                              children: List<Widget>.from(
                                  viewModel.addDatesInNewList().map((data) {
                                    if (data is ChattingModel) {
                                      return ChatTileWidget(data,viewModel.myUserImage.value,viewModel.userImage.value);
                                    } else if (data is DateTime) {
                                      return ChattingDateTile(date: data,);
                                    } else {
                                      return Container();
                                    }
                                  })),
                            );

                        },
                      ):const SizedBox(
                        width: double.maxFinite,
                        child: Center(
                          child: MyText(
                              text:"No Message Found",
                          ),
                        ),
                      ),);
                    }

                    return const SizedBox();
                  })),
            ),
            Obx(() => Visibility(
              visible: viewModel.showDialog.value,
              child: AttachmentDialog(
                  onTapDoc: (){
                    viewModel.showDialog.value = false;
                    viewModel.pickAttachments();
                  },
                  onTapCamera: (){
                    viewModel.showDialog.value = false;
                    viewModel.pickImageFromCamera();
                  },
                  onTapGallery: (){
                    viewModel.showDialog.value = false;
                    viewModel.pickMediaFromGallery();
                  }
              ),
            ),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      color: AppColors.white,
                      minLines: 1,
                      maxLines: 3,
                      controller: viewModel.messageController,
                      focusNode: viewModel.messageFocusNode,
                      hintText: "type_your_msg_here".tr,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      limit: Constants.descriptionLimit,
                      onChanged: (newVal){
                        if(newVal.startsWith(' ')){
                          viewModel.messageController.text = '';
                        }

                        if(viewModel.messageController.text.isNotEmpty){
                          viewModel.isMessageSend.value = true;
                        }else{
                          viewModel.isMessageSend.value = false;
                        }
                      },
                      onTap: (){
                        viewModel.showDialog.value = false;
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if(viewModel.scrollController.positions.isNotEmpty){
                            viewModel.scrollController.animateTo(
                              viewModel.scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }

                        });
                      },
                      onFieldSubmitted: (v){
                        viewModel.isMessageSend.value = false;
                        viewModel.messageController.value.text.trim();

                        if(viewModel.messageController.text.isNotEmpty){
                          viewModel.sendMessage(
                            viewModel.messageController.value.text, ChatStrings.messageTypeText,);

                          viewModel.messageController.text = "";
                          Future.delayed(const Duration(milliseconds: 300), () {
                            viewModel.scrollController.animateTo(
                              viewModel
                                  .scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          });
                        }

                      },
                      prefixWidget: GestureDetector(
                        onTap: (){
                          viewModel.messageFocusNode.unfocus();
                          if(viewModel.showDialog.value){
                            viewModel.showDialog.value = false;
                          }else{
                            viewModel.showDialog.value = true;
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: AppDimen.contentSpacing,top: AppDimen.verticalSpacing,bottom: AppDimen.verticalSpacing),
                          child: CommonImageView(
                            svgPath: AppImages.attachment,
                          ),
                        ),
                      ),
                      suffixWidget: GestureDetector(
                        onTap: (){
                          Util.showBottomPanel(context, VoiceMessageView(), isDismissible: false).then((value) async {
                            debugPrint("value is: $value");
                            Get.delete<VoiceMessageController>();
                            if (value != null) {
                              print(value);
                              viewModel.sendMediaMessage(path.basename(value), ChatStrings.messageTypeAudio, File(value),'');
                            }
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right:AppDimen.contentSpacing,top: AppDimen.pagesVerticalPadding,bottom: AppDimen.pagesVerticalPadding),
                          child: CommonImageView(
                            svgPath: AppImages.mic,
                          ),
                        ),
                      ),
                    ),
                  ),
                    SizedBox(width: AppDimen.horizontalSpacing.w,),
                  Obx(() => GestureDetector(
                    onTap: (){
                      viewModel.isMessageSend.value = false;
                      viewModel.messageController.value.text.trim();

                      if(viewModel.messageController.text.isNotEmpty){
                        viewModel.sendMessage(
                          viewModel.messageController.value.text, ChatStrings.messageTypeText,);

                        viewModel.messageController.text = "";
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if(viewModel.scrollController.positions.isNotEmpty) {
                            viewModel.scrollController.animateTo(
                              viewModel
                                  .scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        });


                      }

                    },
                    child: CommonImageView(
                      svgPath: AppImages.snd,
                      color: viewModel.isMessageSend.value?AppColors.red:AppColors.gray600,
                    ),
                  ),)
                ],
              ),
            ),
            const SizedBox(height: AppDimen.pagesVerticalPadding,),
          ],
        ));
  }
}
