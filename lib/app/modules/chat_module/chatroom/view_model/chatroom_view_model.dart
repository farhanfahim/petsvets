import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../../utils/Util.dart';
import 'package:collection/collection.dart';
import '../../../../../utils/app_font_size.dart';
import '../../../../../utils/bottom_sheet_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/file_picker_util.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../components/bottom_sheets/custom_bottom_sheet.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../components/widgets/custom_textfield.dart';
import '../../../../data/enums/PickerType.dart';
import 'package:path/path.dart' as path;
import '../../../../data/models/user_model.dart';
import '../../../../firestore/chat_constants.dart';
import '../../../../firestore/chat_detail.dart';
import '../../../../firestore/chat_strings.dart';
import '../../../../firestore/chatting_model.dart';
import '../../../../firestore/firestore_controller.dart';
import '../../../../repository/media_upload_repository.dart';

class ChatRoomViewModel extends GetxController with GetTickerProviderStateMixin{

  RxList<String> arrOfOption = List<String>.empty().obs;
  RxList<String> arrOfMoreOption = List<String>.empty().obs;
  StatusType? type;
  var formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController(text: "");
  FocusNode reasonNode = FocusNode();


  RxBool absorb = false.obs;
  RxBool showDialog = false.obs;
  RxBool isMessageSend = false.obs;
  final ScrollController scrollController=ScrollController();
  RxString imagePaths = "".obs;
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  RxList<ChattingModel> chatList = List<ChattingModel>.empty().obs;

  Rx<UserModel> userModel = UserModel().obs;
  var map = Get.arguments;
  Rx<ChatDetail>? chatDetail = ChatDetail().obs;
  RxString documentId = "".obs;
  RxString myUserId = "".obs;
  RxString myUserImage = "".obs;
  RxString userImage = "".obs;
  RxString userId = "".obs;

  Rxn<File?> fileImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();

    arrOfOption.add("report_chat".tr);

    arrOfMoreOption.add("False Information");
    arrOfMoreOption.add("Spam");
    arrOfMoreOption.add("Harassment");
    arrOfMoreOption.add("Other");

    print(map);
    if (map != null ) {


      if (map[ChatConstants.userId] != null) {
        userId.value = map[ChatConstants.userId].toString();
        FirebaseFirestore.instance.collection(ChatStrings.usersCollectionReference).doc(userId.value).snapshots().first.then((value) {
          userImage.value = value.get('image');
        });
      }

      if (map[ChatConstants.documentId] != null) {
        documentId.value = map[ChatConstants.documentId].toString();
      }

      AppPreferences.getUserDetails().then((value) {
        userModel.value = value!;
        myUserId.value = userModel.value.user!.id!.toString();
        myUserImage.value = userModel.value.user!.userImage!=null?userModel.value.user!.userImage!.mediaUrl!:"";
        if(!map[ChatConstants.fromCreation]){
          observeChatData();
          markMessagesRead();
        }

      });

    }



  }

  onTapReport(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "select_action".tr,
          widget: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
            itemCount: arrOfOption.length,
            itemBuilder: (BuildContext context, int subIndex) {
              return GestureDetector(
                onTap: (){
                  Get.back();
                  moreReportOption();
                },
                child: Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                  child: MyText(
                    text: arrOfOption[subIndex],
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  moreReportOption(){
    BottomSheetService.showGenericBottomSheet(
        child: CustomBottomSheet(
          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "cancel".tr,
          actionColor: AppColors.gray600,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "report".tr,
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimen.allPadding),
                child: MyText(text: "report_desc".tr,
                  color: AppColors.gray600,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,),
              ),

              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: AppDimen.pagesVerticalPaddingNew),
                itemCount: arrOfMoreOption.length,
                itemBuilder: (BuildContext context, int subIndex) {
                  return GestureDetector(
                    onTap: (){
                      if(arrOfMoreOption[subIndex] == "Other"){
                        Get.back();
                        openOtherBottomSheet();
                      }else{
                        Get.back();
                        Get.back();
                        Util.showAlert(title: "your_report_has_been_submitted");
                      }

                    },
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal:AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),
                      child: MyText(
                        text: arrOfMoreOption[subIndex],
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          actionTap: () {
            Get.back();
          },
        ));
  }

  openOtherBottomSheet(){
    BottomSheetService.showGenericBottomSheet(
        child:  CustomBottomSheet(

          showHeader: true,
          showClose: false,
          showAction: true,
          showBottomBtn: false,
          centerTitle: false,
          titleSize: AppFontSize.small,
          actionText: "done".tr,
          actionColor: AppColors.red,
          verticalPadding: AppDimen.pagesVerticalPadding,
          title: "report".tr,

          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding,vertical: AppDimen.pagesVerticalPadding),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Padding(
                  padding: const EdgeInsets.only(top: 5.0,bottom: 5),
                  child: MyText(
                    text: "reason".tr,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),

                Form(
                  key: formKey,
                  child: CustomTextField(
                    controller: reasonController,
                    focusNode: reasonNode,
                    hintText: "reason".tr,
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.name,
                    limit: Constants.descriptionLimit,
                    validator: (value) {
                      return HelperFunction.validateValue(value!,"reason".tr);
                    },
                  ),),
                const SizedBox(height: AppDimen.pagesVerticalPaddingNew,)
              ],
            ),
          ),
          actionTap: (){
            if (formKey.currentState?.validate() == true) {
              Get.back();
              Get.back();
              Util.showAlert(title: "your_report_has_been_submitted");
            } else {
              print('not validated');
            }

          },
        )
    );
  }

  void pickImageFromCamera() async {
    final pickedFile = await FilePickerUtil.pickImages(pickerType: PickerType.camera);
    if (pickedFile != null && pickedFile.isNotEmpty) {
      for(var item in pickedFile){
        fileImage.value = File(item.path!);
        sendMediaMessage(path.basename(item.path!), ChatStrings.messageTypeImage, fileImage.value!,"");
       messageFocusNode.unfocus();
        messageController.text = "";
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollController.animateTo(
          scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });

      }
      Util.hideKeyBoard(Get.context!);

    }
  }

  void pickMediaFromGallery() async {
    final pickedFile = await FilePickerUtil.pickMedia();

    if (pickedFile != null && pickedFile.isNotEmpty) {
      for(var item in pickedFile){
        fileImage.value = File(item.path!);
        if(item.galleryMode == GalleryMode.video){
          sendMediaMessage(path.basename(item.path!), ChatStrings.messageTypeVideo, fileImage.value!,item.thumbPath!);
        }else{
          sendMediaMessage(path.basename(item.path!), ChatStrings.messageTypeImage, fileImage.value!,"");

        }
        messageFocusNode.unfocus();
        messageController.text = "";
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      }
      Util.hideKeyBoard(Get.context!);
    }
  }

  void pickAttachments() async {
    final pickedFile = await FilePickerUtil.pickSingleFile();
    if (pickedFile != null) {
      fileImage.value = File(pickedFile.path);
      sendMediaMessage(path.basename(pickedFile.path), ChatStrings.messageTypeFile, fileImage.value!,"");
       messageFocusNode.unfocus();
      messageController.text = "";
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
      Util.hideKeyBoard(Get.context!);
    }
  }

  sendMessage(String message, int type) {
    if(!map[ChatConstants.fromCreation]){
      observeChatData();
      markMessagesRead();
    }
    FirestoreController.instance.saveMsgToChatRoom(
        chatDetail!.value,
        documentId.isNotEmpty ? documentId.value : null,
        myUserId.value,
        userId.value,
        message,
        userModel.value.user!.roles!.first.id ==2?false:true,
        map[ChatConstants.fromCreation],
        type,
        "",
        File(""));

    messageController.text = "";
    messageController.text.isEmpty
        ? isMessageSend.value = false
        : isMessageSend.value = true;

    try {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {}
  }

  sendMediaMessage(String message,int type,File url,String thumbnail) {
    if(!map[ChatConstants.fromCreation]){
      observeChatData();
      markMessagesRead();
    }
    FirestoreController.instance.saveMsgToChatRoom(
        chatDetail!.value,
        documentId.isNotEmpty ? documentId.value : null,
        myUserId.value,
        userId.value,
        message,
        userModel.value.user!.roles!.first.id ==2?false:true,
        map[ChatConstants.fromCreation],
        type,
        thumbnail,
        url,);

    messageController.text = "";
    messageController.text.isEmpty
        ? isMessageSend.value = false
        : isMessageSend.value = true;

    try {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {}
  }


  void markMessagesRead() async {
    if (documentId.isNotEmpty) {
      final CollectionReference threadsCollection = FirebaseFirestore.instance
          .collection(ChatStrings.chatsCollectionReference)
          .doc(documentId.value)
          .collection(ChatStrings.threadsCollectionReference);

      final WriteBatch batch = FirebaseFirestore.instance.batch();


      final QuerySnapshot querySnapshot = await threadsCollection
          .where(ChatStrings.senderId, isNotEqualTo: int.parse(myUserId.value))
          .get();
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        batch.update(document.reference, {ChatStrings.isRead: true});
      });

      await batch.commit();
    }
  }

  void observeChatData() {
    if (documentId.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(ChatStrings.chatsCollectionReference)
          .doc(documentId.value)
          .snapshots()
          .listen((chatDetailSnapshot) {
        chatDetail!.value = ChatDetail.fromJson(chatDetailSnapshot.data()!);
      });
    }
  }

  List<dynamic> addDatesInNewList() {
    List<dynamic> _returnList;
    List<dynamic> _newData = addChatDateInSnapshot(chatList);
    _returnList = List<dynamic>.from(_newData.reversed);
    return _returnList;
  }

  List<dynamic> addChatDateInSnapshot(List<ChattingModel> snapshot) {
    List<dynamic> _returnList = [];

    RxString currentDate = "".obs;

    for (ChattingModel item in snapshot) {
      var format = DateFormat('EEEE, MMM d, yyyy');
      var date = item.time!=null?item.time!.toDate(): DateTime.now();
      if (currentDate.value.isEmpty) {
        currentDate.value = format.format(date);
        _returnList.add(date);
      }

      if (currentDate.value == format.format(date)) {
        _returnList.add(item);
      } else {
        currentDate.value = format.format(date);
        _returnList.add( item.time!=null?item.time!.toDate(): DateTime.now());
        _returnList.add(item);
      }
    }
    return _returnList;
  }

  Future<Stream<List<ChattingModel>>> getChatMessages() async {
    if(documentId.value.isNotEmpty) {

      FirebaseFirestore.instance
          .collection(ChatStrings.chatsCollectionReference)
          .doc(documentId.value)
          .collection(ChatStrings.threadsCollectionReference)
          .orderBy(ChatStrings.createdAt, descending: false)
          .snapshots()
          .listen((chatListSnapshot) {
        chatList.clear();

        for (var chatMessageDocument in chatListSnapshot.docs) {
          chatList.add(ChattingModel(
            id: chatMessageDocument[ChatStrings.id],
            type: chatMessageDocument[ChatStrings.messageType],
            userId: int.parse(myUserId.value),
            senderId: chatMessageDocument[ChatStrings.senderId],
            text: chatMessageDocument[ChatStrings.text],
            file: chatMessageDocument[ChatStrings.fileUrl],
            audio: chatMessageDocument[ChatStrings.audioUrl],
            image: chatMessageDocument[ChatStrings.imageUrl],
            video: chatMessageDocument[ChatStrings.videoUrl],
            time: chatMessageDocument[ChatStrings.createdAt],
          ));
        }
      });
    }

    return chatList.stream;
  }

  bool isDateToday(DateTime date) {
    final now = DateTime.now();
    final inputDate = DateTime(date.year, date.month, date.day);

    return now.year == inputDate.year &&
        now.month == inputDate.month &&
        now.day == inputDate.day;
  }


}
