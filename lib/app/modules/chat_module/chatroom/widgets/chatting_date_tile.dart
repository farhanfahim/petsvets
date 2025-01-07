import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petsvet_connect/app/modules/chat_module/chatroom/view_model/chatroom_view_model.dart';
import '../../../../components/widgets/MyText.dart';

class ChattingDateTile extends StatelessWidget {
  ChattingDateTile({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  ChatRoomViewModel controller = Get.find();
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: controller.isDateToday(date)?Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyText(
            text:"Today, ",
          ),
          MyText(
            text:getTime(date),
          ),
        ],
      ):Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: "${getDay(date)}, ",
          ),
          MyText(
          text:getTime(date),

          ),

        ],
      ),
    );
  }


  static String getTime(DateTime dateTime) {
    var xxx = DateFormat("hh:mm a").format(dateTime);
    return xxx.toString();
  }

  static String getDay(DateTime dateTime) {
    var xxx = DateFormat("MMM d").format(dateTime);
    return xxx.toString();
  }

}
