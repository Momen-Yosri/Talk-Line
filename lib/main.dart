import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/provider/user_provider.dart';
import 'package:talk_line/features/chat_screen/chat_screen.dart';
import 'package:talk_line/features/home_screen/home_screen_view.dart';
import 'package:talk_line/features/authentication/Auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/style/app_style.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
 await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      theme:MyThemeData.AppTheme,
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
