import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/view/chat_screen/custom_message.dart';

class ChatScreen extends StatefulWidget {
    static const String routeName="chat_screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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