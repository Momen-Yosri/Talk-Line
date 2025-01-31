import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk_line/features/authentication/widgets/custom_section.dart';
import 'package:talk_line/features/authentication/login/login_templete.dart';
import 'package:talk_line/features/authentication/register/register_templeter.dart';

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
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
        
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg/logo.svg',height: 150.h,),
                    SizedBox(width: 24.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Your presence makes this place brighter"),
                        DefaultTextStyle(
                            style:  TextStyle(
                              fontSize: 20.0.sp,
                              fontFamily: 'Canterbury',
                            ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                ScaleAnimatedText('Come on in,'),
                                ScaleAnimatedText('relax,'),
                                ScaleAnimatedText('and enjoy the moment!'),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                      ],
                    ),]),
                    SizedBox(
              height: 60.h,
            ),
                
                Row(
                  children: [
                    Text(
                      selectedTab ? "Login On Your Account" : "Welcome to our Family",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() => selectedTab = true);
                        },
                        child: CustomSection(
                          selected: selectedTab,
                          selectedIcon: Icons.login,
                          title: "login",
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() => selectedTab = false);
                        },
                        child: CustomSection(
                          selected: !selectedTab,
                          selectedIcon: Icons.app_registration_outlined,
                          title: "Register",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 20.0),
                child: selectedTab ? LoginTemplate() : RegisterTemplate(),
              ),
            ),
          ),
        ],
         
      ),
    );
  }}
  //Widget build(BuildContext context) {
//     return Scaffold(
//           resizeToAvoidBottomInset: true,
//       body: Form(key:_formKey,
//       child: Padding(
//         padding:  REdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 Text(selectedTab?"Login On Your Account":"Welcome to our Family",style: Theme.of(context).textTheme.titleLarge,),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(child:   InkWell(onTap: () {
//                   selectedTab=true;
//                   setState(() {});
                  
//                 },child:CustomSection(selected:selectedTab? true:false,selectedIcon:Icons.login ,title: "login",)))
//               ,Expanded(child:   InkWell(onTap: () {
//                   selectedTab=false;
//                   setState(() {});
                  
//                 },child:CustomSection(selected:selectedTab? false:true,selectedIcon:Icons.app_registration_outlined,title: "Registert",)))],),
//             SizedBox(
//               height: 36.h,
//             ),
//             Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: REdgeInsets.symmetric(horizontal: 20.0),
//                 child: selectedTab ? LoginTemplate() : RegisterTemplate(),
//               ),
//             ),
//           ),
//           ],
//         ),
//       ),
//     ),);
//   }
// }