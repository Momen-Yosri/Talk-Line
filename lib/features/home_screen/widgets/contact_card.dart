import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/core/model/room_model.dart';
import 'package:talk_line/features/chat_screen/chat_screen.dart';
class RoomCard extends StatelessWidget {
  RoomModel room;
  // final String name;
  // final String description;
   String image;
   RoomCard({super.key ,required this.image,required this.room}) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // navigate to chat room
        Navigator.pushNamed(context, ChatScreen.routeName,arguments:room );
      },
      child: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(vertical: 20.0),
            child: Row(children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/room.png"),
                radius: 30.r,
              ),
              SizedBox(width: 16.w),Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(room.roomName??"error",style: Theme.of(context).textTheme.bodyLarge,),
                  Text(room.roomDescription??"error",style: Theme.of(context).textTheme.bodyMedium),
                ],
              )]
              ),
          ),
           
            Divider(),
        ],
      ),
    );
  }
}