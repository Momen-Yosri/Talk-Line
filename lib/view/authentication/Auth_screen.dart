import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/view/authentication/widgets/custom_section.dart';
import 'package:talk_line/view/authentication/widgets/login_templete.dart';
import 'package:talk_line/view/authentication/widgets/register_templeter.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String routeName="Authentication_screen";

   AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool selectedTab= true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(key:_formKey,
      child: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(selectedTab?"Login On Your Account":"Welcome to our Family",style: Theme.of(context).textTheme.titleLarge,),
              ],
            ),
            Row(
              children: [
                Expanded(child:   InkWell(onTap: () {
                  selectedTab=true;
                  setState(() {});
                  
                },child:CustomSection(selected:selectedTab? true:false,selectedIcon:Icons.login ,title: "login",)))
              ,Expanded(child:   InkWell(onTap: () {
                  selectedTab=false;
                  setState(() {});
                  
                },child:CustomSection(selected:selectedTab? false:true,selectedIcon:Icons.app_registration_outlined,title: "Registert",)))],),
            SizedBox(
              height: 36.h,
            ),
            selectedTab?LoginTemplate():RegisterTemplate(),
          ],
        ),
      ),
    ),);
  }
}