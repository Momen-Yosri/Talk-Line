import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_line/core/utils/data_base.dart';
import 'package:talk_line/core/model/message_model.dart';
import 'package:talk_line/core/model/user_model.dart';
import 'package:talk_line/features/chat_screen/chat_navigator.dart';
import '../../core/model/room_model.dart';

class ChatViewModel extends ChangeNotifier
{
  late ChatNavigator navigator;
  late UserModel currentUser;
  late RoomModel room;
  late Stream<QuerySnapshot<MessageModel>> groupMessages;
  void sendMessagea(String content)async{
    MessageModel message = MessageModel(
      senderID: currentUser.id??"",
      roomID: room.roomId??"",
      dateTime: DateTime.now().millisecondsSinceEpoch, 
      messageContent: content, 
      senderName: currentUser.name??""
    );
    try{  
      var result =await DataBaseUtils.insertMessage(message);
    navigator.clearMessage();
    }
    catch(error){
      print(error);
    navigator.showMessage(error.toString());
    }
  }
  void listenForUpdatedMessages(){
groupMessages= DataBaseUtils.getMessages(room.roomId);
  }
}
