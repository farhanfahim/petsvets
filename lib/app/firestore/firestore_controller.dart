import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:petsvet_connect/app/data/models/user_model.dart';
import 'package:uuid/uuid.dart';
import '../../utils/Util.dart';
import '../repository/media_upload_repository.dart';
import '../repository_imp/media_upload_repository_imp.dart';
import 'chat_constants.dart';
import 'chat_detail.dart';
import 'chat_strings.dart';

class FirestoreController {
  static FirestoreController get instance => FirestoreController();
  var mediaRepo = Get.put<MediaUploadRepository>(MediaUploadRepositoryImpl());

  Future<String> saveUserData(int? id, String? name, String? email, String? image,int? role) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection(ChatStrings.usersCollectionReference)
        .where('id', isEqualTo: id.toString())
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    try {
      if (documents.isEmpty) {
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection(ChatStrings.usersCollectionReference)
            .doc(id!.toString());
        FirebaseFirestore.instance
            .runTransaction((Transaction myTransaction) async {
          myTransaction.set(userDoc, {
            'id': id.toString(),
            'name': name,
            'email': email,
            'online': false,
            'role': role,
            'image': image ?? "",
          });
        });
      }
    } catch (ex) {
      print(ex);
    }

    return id!.toString();
  }

  Future<String> updateUserData(User response) async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection(ChatStrings.usersCollectionReference)
        .doc(response.id.toString());
    doc.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        doc.update({
          'name': response.fullName,
          'image': response.userImage != null
              ? response.userImage!.mediaUrl!.isNotEmpty
                  ? response.userImage!.mediaUrl
                  : ""
              : "",
        });
      }
    });
    return "";
  }

  Future chatStatus({String? userID, bool? onlineStatus}) async {
    await FirebaseFirestore.instance
        .collection(ChatStrings.usersCollectionReference)
        .doc(userID)
        .update({'online': onlineStatus});
  }

  Future saveMsgToChatRoom(
      ChatDetail chatDetail,
      String? _documentId,
      String myId,
      String userId,
      String? message,
      bool? isFollowUp,
      bool? isFirstTIme,
      int messageType,
      String thumbnail,
      File url,) async {
    if (isFirstTIme!) {
      ///Create new chat
       await FirebaseFirestore.instance.collection(ChatStrings.chatsCollectionReference).doc(_documentId).set({
        ChatStrings.userIds: [int.parse(myId), int.parse(userId)], //user id list
        ChatStrings.createdAt: FieldValue.serverTimestamp(),
        ChatStrings.updatedAt: FieldValue.serverTimestamp(),
        ChatStrings.lastMessage: message,
        ChatStrings.isFollowUp: isFollowUp,
      });

    } else {

      ///To Update all chat members
      FirebaseFirestore.instance.collection(ChatStrings.chatsCollectionReference).doc(_documentId).update({
        ChatStrings.updatedAt: FieldValue.serverTimestamp(),
        ChatStrings.lastMessage: message,
      }).then((value) => print("Chat document updated"));
    }

    ///Update thread everytime with new message
    final _uuid = const Uuid();

    var threadDocument = await FirebaseFirestore.instance
        .collection(ChatStrings.chatsCollectionReference)
        .doc(_documentId)
        .collection(ChatStrings.threadsCollectionReference)
        .add({
      ChatStrings.isRead: false,
      ChatStrings.fileUrl: "",
      ChatStrings.audioUrl: "",
      ChatStrings.imageUrl: "",
      ChatStrings.videoUrl: "",
      ChatStrings.messageType: messageType,
      ChatStrings.senderId: int.parse(myId),
      ChatStrings.text: message,
      ChatStrings.createdAt: FieldValue.serverTimestamp(),
      ChatStrings.id: _uuid.v1(),

    });
    print("Chat thread created: ${threadDocument.id}");

    print("Message sent");
    if(messageType != ChatStrings.messageTypeText) {
      uploadMediaToBucket(threadDocument, message!, messageType, File(thumbnail),true);
      uploadMediaToBucket(threadDocument, message, messageType, url,false);
    }

  }


  Future<dynamic>  uploadMediaToBucket(DocumentReference<Map<String,dynamic>> threadDocument,String fileName,int type,File url,bool isThumbnail) async {
    var fileMimeType = lookupMimeType(url.path)!;

    debugPrint("file mime type: $fileMimeType");
    if (fileMimeType == "audio/mp4" || fileMimeType == "audio/x-wav") {
      fileMimeType = "audio/mp3";
    }
    var map = {'contentType': fileMimeType};
    debugPrint("file mime type: $fileMimeType");
    print(map);
    final result = await mediaRepo.getBucketDetailsForFileUpload(map);
    result.fold((l) {
      threadDocument.delete();
      Util.showAlert(title: l.message, error: true);

    }, (response) async {

      Map<String, dynamic> map = {
        'url': response.data.result!.url,
        'acl': response.data.result!.fields!.aCL,
        'contentType': response.data.result!.fields!.contentType,
        'bucket': response.data.result!.fields!.bucket,
        'algorithm': response.data.result!.fields!.xAmzAlgorithm,
        'credentials': response.data.result!.fields!.xAmzCredential,
        'date': response.data.result!.fields!.xAmzDate,
        'key': response.data.result!.fields!.key,
        'policy': response.data.result!.fields!.policy,
        'signature': response.data.result!.fields!.xAmzSignature,
        'image': url.path,
        'fileName': url.path.split('/').last
      };
      final result = await mediaRepo.uploadFile(map);
      result.fold((l) {
        threadDocument.delete();
      }, (response) async {
        if (type == ChatStrings.messageTypeImage) {
          print("Message with image");
          threadDocument.update({ChatStrings.imageUrl: response,});
        }if (type == ChatStrings.messageTypeVideo) {
          print("Message with Video");
          if(isThumbnail){
            threadDocument.update({ChatStrings.imageUrl: response,});
          }else{
            threadDocument.update({ChatStrings.videoUrl: response,});
          }

        }if (type == ChatStrings.messageTypeFile) {
          print("Message with Attachment");
          threadDocument.update({ChatStrings.fileUrl: response,});
        }if (type == ChatStrings.messageTypeAudio) {
          print("Message with Audio");
          threadDocument.update({ChatStrings.audioUrl: response,});
        }


      });
    });
  }

}
