import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/style/app_colors.dart';
import 'package:talk_line/core/model/room_model.dart';
import 'package:talk_line/features/chat_screen/chat_navigator.dart';
import 'package:talk_line/features/chat_screen/chat_view_model.dart';
import 'package:talk_line/features/chat_screen/widgets/custom_message.dart';
import 'package:talk_line/features/genrals/custom_snack_bar.dart';

import '../../core/provider/user_provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "chat_screen";

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
        viewModel.listenForUpdatedMessages();

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Light background for better contrast
        appBar: AppBar(
          elevation: 1, // Subtle shadow
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/room.png",
                    height: 40.h,
                    width: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      args.roomName,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Online', // You can make this dynamic
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.primaryColor),
              onPressed: () {}, // Add room settings functionality
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: viewModel.groupMessages,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (asyncSnapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, 
                            size: 48, 
                            color: Colors.red[300]
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Error: ${asyncSnapshot.error}",
                            style: TextStyle(color: Colors.red[300]),
                          ),
                        ],
                      ),
                    );
                  }

                  var messagesList = asyncSnapshot.data?.docs
                          .map((doc) => doc.data())
                          .toList() ??
                      [];

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      var message = messagesList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: CustomMessage(
                          message: message.messageContent,
                          senderName: message.senderName,
                          isSentByMe: message.senderID == viewModel.currentUser.id,
                          senderAvatar: viewModel.currentUser.avatar??'assets/svg/avatars/6.svg',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.attach_file,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {}, // Add attachment functionality
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (messageController.text.trim().isNotEmpty) {
                          viewModel.sendMessagea(messageController.text);
                          messageController.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void clearMessage() {
    messageController.clear();
  }

  @override
  void showMessage(String message) {
    CustomSnackBar.show(context, message: message, isSuccess: true);
  }
}
