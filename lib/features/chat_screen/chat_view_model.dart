import 'package:flutter/material.dart';
import 'package:talk_line/core/model/data_base.dart';
import 'package:talk_line/core/model/message_model.dart';
import 'package:talk_line/core/model/user_model.dart';
import 'package:talk_line/features/chat_screen/chat_navigator.dart';

class ChatViewModel extends ChangeNotifier
{
  late ChatNavigator navigator;
  late UserModel currentUser;
  void sendMessage()
  {
    MessageModel message = MessageModel(
      senderID: currentUser.id??"",
      roomID: "roomId",
      dateTime: DateTime.now().millisecondsSinceEpoch, messageContent: '', senderName: currentUser.name??""
    );
    DataBaseUtils.insertMessage(message);
  }
}
// min no. 24
