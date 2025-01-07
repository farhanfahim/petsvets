
import 'package:petsvet_connect/app/components/resources/app_images.dart';

class ChatRoomModel {
  String type;
  final String messageType;
  final String name;
  final String image;
  final String imageUrl;
  final String time;
  final String message;

  ChatRoomModel({
    required this.type,
    required this.messageType,
    required this.name,
    required this.image,
    this.imageUrl = "",
    required this.time,
    required this.message,
  });

  static List<ChatRoomModel> dummyDataList = [
    ChatRoomModel(
        type: "receiver",
        messageType: "time",
        name: "",
        time: "12:56 PM",
        message: 'WHi! Do you need any help?',
        image: AppImages.userDummyImg),
    ChatRoomModel(
        type: "sender",
        messageType: "text",
        name: "",
        time: "",
        message: 'Hi! I\'m not able to visit links',
        image: AppImages.userDummyImg2),
    ChatRoomModel(
        type: "sender",
        messageType: "text",
        name: "",
        time: "12:56 PM",
        message: 'Kindly look into this.',
        image: AppImages.userDummyImg2),
    ChatRoomModel(
        type: "receiver",
        messageType: "text",
        name: "",
        time: "12:56 PM",
        message: 'I’ll look into this.',
        image: AppImages.userDummyImg),
    ChatRoomModel(
        type: "sender",
        messageType: "text",
        name: "",
        time: "",
        message: 'Hi! I\'m not able to visit links',
        image: AppImages.userDummyImg2),
    ChatRoomModel(
        type: "sender",
        messageType: "image",
        name: "",
        imageUrl: "",
        time: "12:56 PM",
        message: 'I’ll look into this.',
        image: AppImages.userDummyImg2),

  ];
}
