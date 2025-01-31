import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMessage extends StatelessWidget {
  final String message;
  final String senderName;
  final String senderAvatar;
  final bool isSentByMe;

   CustomMessage({
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
                          color: Colors.white, // Added white text for better contrast
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
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:talk_line/core/style/app_colors.dart';

// class CustomMessage extends StatelessWidget {
//   final bool sender;
//   const CustomMessage({super.key,required this.sender}) ;

//   @override
//   Widget build(BuildContext context) {
//     return Container( 
//             decoration: BoxDecoration(
//             color:sender? AppColors.primaryColor:Color(0xffAD87E4),
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20.0.r),
//             bottomRight: Radius.circular(sender?20.0.r:0),
//             topLeft: Radius.circular(20.0.r),
//             bottomLeft: Radius.circular(sender?0:20.0.r)),
//       ),
      
//             child: Padding(
//               padding:  REdgeInsets.all(8.0),
//               child: Text("Hello world",style: sender?Theme.of(context).textTheme.labelMedium:Theme.of(context).textTheme.labelSmall,),
//             ));
//   }
// }