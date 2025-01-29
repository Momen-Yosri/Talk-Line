import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_line/core/style/app_colors.dart';

class MyThemeData {
  static final ThemeData AppTheme =  ThemeData(
        appBarTheme: AppBarTheme(titleTextStyle: GoogleFonts.sora(fontSize: 22.sp,fontWeight: FontWeight.w600,color: Colors.white),color: AppColors.primaryColor,shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(25.r),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white), backgroundColor: MaterialStateProperty.all(AppColors.primaryColor))),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.sora(color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w400),
          titleMedium: GoogleFonts.sora(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w600),
          bodyLarge: GoogleFonts.sora(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.sora(color: Color(0xff636363), fontSize: 11.sp, fontWeight: FontWeight.w400),
          labelMedium:GoogleFonts.sora(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w400) ,
          labelSmall:GoogleFonts.sora(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w400) ,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
}
