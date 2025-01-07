import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../firestore/chat_constants.dart';
import '../../../../firestore/chat_strings.dart';
import '../../current_chats/widgets/inbox_tile.dart';
import '../view_model/follow_up_chat_view_model.dart';

class FollowUpChatView extends StatelessWidget {
  final FollowUpChatViewModel viewModel = Get.put(FollowUpChatViewModel());

  FollowUpChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        showAppBar: false,
        showHeader: false,
        hasBackButton: true.obs,
        horizontalPadding: false,
        verticalPadding: false,
        centerTitle: true,
        screenName: "chats".tr,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: StreamBuilder<QuerySnapshot>(
            ///Stream for my chats
            ///Get chats:
            ///1. Me exist
            stream: FirebaseFirestore.instance
                .collection(ChatStrings.chatsCollectionReference)
                .where(ChatStrings.isFollowUp, isEqualTo: true)
                .orderBy(ChatStrings.updatedAt, descending: true)
                .snapshots(),
            builder: (context, chatListSnapshot) {
              if (chatListSnapshot.hasData) {
                return chatListSnapshot.requireData.size == 0
                    ? Center(
                    child: GestureDetector(
                      child: const Text(
                        ChatConstants.noChatFound,
                      ),
                    ))
                    : ListView.builder(
                  itemCount: chatListSnapshot.requireData.size,
                  itemBuilder: (context, index) {
                    var chatDocument = chatListSnapshot.requireData.docs[index];

                    int? otherUserId;

                    ///Get other user id only for single chat
                    otherUserId = chatDocument.get(ChatStrings.userIds).where((id) => id != viewModel.userId!.value).single;

                    return StreamBuilder<DocumentSnapshot>(

                      ///Stream to get user info against user id if one-to-one chat
                      ///User details for:
                      ///1. Name
                      ///2. Image
                        stream: FirebaseFirestore.instance.collection(ChatStrings.usersCollectionReference).doc(otherUserId.toString()).snapshots(),
                        builder: (context, userSnapshot) {

                          ///If one-to-one chat
                          ///Check if user data is fetched then show widget
                          if (userSnapshot.hasData) {

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(ChatStrings.chatsCollectionReference)
                                  .doc(chatDocument.id)
                                  .collection(ChatStrings.threadsCollectionReference)
                                  .where(ChatStrings.senderId, isNotEqualTo: viewModel.userId!.value)
                                  .where(ChatStrings.isRead, isEqualTo: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    InboxTile(
                                      imageUrl:userSnapshot.requireData.get(ChatStrings.image),
                                      username:userSnapshot.requireData.get(ChatStrings.name),
                                      lastMessage:chatDocument.get(ChatStrings.lastMessage),
                                      time:chatDocument[ChatStrings.updatedAt] == null
                                          ? ""
                                          : DateTimeUtil.timeAgoSinceDateFirebase(((chatDocument[ChatStrings.updatedAt]) as Timestamp).toDate()),
                                      unReadMessages:snapshot.hasData ? snapshot.requireData.size.obs : 0.obs,
                                      onTap: () {

                                        Map<String, dynamic> map = {
                                          ChatConstants.documentId: chatListSnapshot.data?.docs[index].id,
                                          ChatConstants.threadName: userSnapshot.requireData.get(ChatStrings.name),
                                          ChatConstants.fromCreation: false,
                                          ChatConstants.userId:  userSnapshot.requireData.get(ChatStrings.id),
                                        };
                                        Get.toNamed(Routes.CHAT_ROOM,arguments: map);

                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        });
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),);
  }
}
