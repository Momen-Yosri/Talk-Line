import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';

class CustomMessage extends StatelessWidget {
  final bool sender;
  const CustomMessage({super.key,required this.sender}) ;

  @override
  Widget build(BuildContext context) {
    return Container( 
            decoration: BoxDecoration(
            color:sender? AppColors.primaryColor:Color(0xffAD87E4),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0.r),
            bottomRight: Radius.circular(sender?20.0.r:0),
            topLeft: Radius.circular(20.0.r),
            bottomLeft: Radius.circular(sender?0:20.0.r)),
      ),
      
            child: Padding(
              padding:  REdgeInsets.all(8.0),
              child: Text("Hello world",style: sender?Theme.of(context).textTheme.labelMedium:Theme.of(context).textTheme.labelSmall,),
            ));
  }
}