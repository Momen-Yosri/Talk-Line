import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talk_line/features/authentication/widgets/custom_section.dart';
import 'package:talk_line/features/authentication/login/login_templete.dart';
import 'package:talk_line/features/authentication/register/register_templeter.dart';

import '../../core/style/app_colors.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String routeName = "Authentication_screen";

  AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool selectedTab = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 32.h,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: REdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Top Section with Logo and Animated Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "The room lights up\nwith you here",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    "Come on in,",
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  TyperAnimatedText(
                                    "relax,",
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  TyperAnimatedText(
                                    "and enjoy the moment!",
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Hero(
                            tag: 'app_logo',
                            child: SvgPicture.asset(
                              'assets/svg/logo.svg', 
                              height: 120.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      selectedTab ? "Login On Your Account" : "Welcome to our Family",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => selectedTab = true),
                            child: CustomSection(
                              selected: selectedTab,
                              selectedIcon: Icons.login,
                              title: "login",
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => selectedTab = false),
                            child: CustomSection(
                              selected: !selectedTab,
                              selectedIcon: Icons.app_registration_outlined,
                              title: "Register",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),SizedBox(height: 24.h),
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
  }
}