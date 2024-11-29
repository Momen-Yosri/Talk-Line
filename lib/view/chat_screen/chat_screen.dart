import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';
import 'package:talk_line/view/chat_screen/custom_message.dart';

class ChatScreen extends StatelessWidget {
    static const String routeName="chat_screen";

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Padding(
        padding: REdgeInsets.all(10.0),
        child: Image.asset("assets/Ellipse 5.png"),
      ))
      ,body: Column(
        children: [
          CustomMessage(sender: true,),
          CustomMessage(sender: false,),

        ]
      ),);
  }
}