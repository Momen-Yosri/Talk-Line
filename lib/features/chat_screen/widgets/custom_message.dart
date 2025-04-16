import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMessage extends StatelessWidget {
  final String message;
  final String senderName;
  final String senderAvatar;
  final bool isSentByMe;

    const CustomMessage({
    Key? key,
    required this.message,
     required this.senderName ,
     required this.senderAvatar ,
    this.isSentByMe = false,
  }) : super(key: key);

  // Define custom colors
  static const Color senderColor = Color(0xFF7B3FD3);  // Sender message color #7B3FD3
  static const Color receiverColor = Color(0xFFBD9FE9); // Receiver message color #BD9FE9

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSentByMe) _buildAvatar(),
          const SizedBox(width: 8.0),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isSentByMe ? senderColor : receiverColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: Radius.circular(isSentByMe ? 16.0 : 4.0),
                  bottomRight: Radius.circular(isSentByMe ? 4.0 : 16.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSentByMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.black, // Added white text for better contrast
                        ),
                      ),
                    ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white, // Added white text for better contrast
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          if (isSentByMe) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      // backgroundImage: SvgPicture.asset(senderAvatar),
      backgroundColor: Colors.grey[300],
      child: senderAvatar.isEmpty
          ? Text(
              senderName[0].toUpperCase(),
              style: const TextStyle(fontSize: 20),
            )
          : SvgPicture.asset(senderAvatar),
    );
  }
}