import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/app_colors.dart';
import 'package:talk_line/provider/user_provider.dart';
import 'package:talk_line/view/chat_screen/chat_screen.dart';
import 'package:talk_line/view/home_screen/home_screen_view.dart';
import 'package:talk_line/view/authentication/Auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( ChangeNotifierProvider(child: MyApp(), create: (context) => UserProvider(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
var userProvider = Provider.of<UserProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: AppColors.primaryColor,shape: RoundedRectangleBorder(
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
      ),
      routes: {
        AuthenticationScreen.routeName: (context) =>  AuthenticationScreen(),
        HomeScreenView.routeName: (context) =>  HomeScreenView(),
        ChatScreen.routeName: (context) =>  ChatScreen(),
        // AddRoomView.routeName: (context) =>  AddRoomView(),
      },
      initialRoute: userProvider.firebaseUser==null? AuthenticationScreen.routeName:HomeScreenView.routeName,
    );
  },
    );
  }
}
