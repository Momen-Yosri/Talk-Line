import 'package:flutter/material.dart';
import 'package:talk_line/model/data_base.dart';
import 'package:talk_line/model/room_model.dart';
import 'package:talk_line/view/home_screen/home_screen_navigator.dart';

class HomeScreenViewModel extends ChangeNotifier
{
  late HomeScreenNavigator navigator;

void addRoom(String roomName, String roomDescription) async{
  RoomModel room =RoomModel(roomId: "", roomName: roomName, roomDescription: roomDescription);
  navigator.showLoading();
  try{

var createdRoom = await DataBaseUtils.createRoom(room);
navigator.hideLoading();
navigator.showMessage("Room created successfully", true);
}catch(e){
  navigator.hideLoading();
print(e);
navigator.showMessage(e.toString(), false);
}
  
}}