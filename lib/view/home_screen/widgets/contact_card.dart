import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/view/chat_screen/chat_screen.dart';

class RoomCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  const RoomCard({super.key,required this.name,required this.description,required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // navigate to chat room
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
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
                  Text(name,style: Theme.of(context).textTheme.bodyLarge,),
                  Text(description,style: Theme.of(context).textTheme.bodyMedium),
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