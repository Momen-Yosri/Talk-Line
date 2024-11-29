import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final IconData selectedIcon;
  final bool selected;

  const CustomSection({super.key,required this.title,required this.selectedIcon,required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(selectedIcon),Text(title)],),
          Visibility(child: Container(height: 5.h,width: double.infinity,color:AppColors.primaryColor,) ,visible: selected,)
      ],
    );
  }
}