import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/style/app_colors.dart';
import 'package:talk_line/core/model/room_model.dart';
import 'package:talk_line/core/utils/data_base.dart';
import 'package:talk_line/features/chat_screen/chat_navigator.dart';
import 'package:talk_line/features/chat_screen/chat_view_model.dart';
import 'package:talk_line/features/chat_screen/widgets/custom_message.dart';
import 'package:talk_line/features/genrals/custom_snack_bar.dart';

import '../../core/provider/user_provider.dart';

class ChatScreen extends StatefulWidget {
    static const String routeName="chat_screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  final ChatViewModel viewModel = ChatViewModel();
  final TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as RoomModel; 
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = provider.user!;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title:Row(
          children: [Image.asset("assets/images/room.png",height: 40.h,width: 40.w,),
            Text(args.roomName??""),
          ],
        ) )    ,
        body: Column(
          children: [
            CustomMessage(sender: true,),
            CustomMessage(sender: false,),
            Spacer(),
            Row(children: [
              Expanded(child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Type a message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                ),
              )),
              IconButton(onPressed: (){
                viewModel.sendMessagea(messageController.text);
              }, icon: Icon(Icons.send,color: AppColors.primaryColor,size: 20.sp,))
            ],),
      
          ]
        ),),
    );
  }
  
  @override
  void clearMessage() {
messageController.clear();
  }
  
  @override
  void showMessage(String message) {
          CustomSnackBar.show(context,message: message, isSuccess: true);

  }
}