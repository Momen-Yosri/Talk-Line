import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/style/app_colors.dart';
import 'package:talk_line/core/model/user_model.dart';
import 'package:talk_line/core/provider/user_provider.dart';
import 'package:talk_line/features/authentication/register/register_navigator.dart';
import 'package:talk_line/features/authentication/widgets/custom_form_field.dart';
import 'package:talk_line/features/genrals/custom_snack_bar.dart';
import 'package:talk_line/features/home_screen/home_screen_view.dart';
import 'package:talk_line/features/authentication/register/register_view_model.dart';

import '../widgets/avatar_selector.dart';

class RegisterTemplate extends StatefulWidget {
  RegisterTemplate({super.key});

  @override
  State<RegisterTemplate> createState() => _RegisterTemplateState();
}

class _RegisterTemplateState extends State<RegisterTemplate> implements RegisterNavigator {
  String? selectedAvatar;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    super.initState(); //this because you initialize the navigator in the view model using late
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
       child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            AvatarSelector(
              onAvatarSelected: (String avatarPath) {
                setState(() {
                  selectedAvatar = avatarPath;
                });}),
            SizedBox(height: 20.h),
            CustomTextFormField(
                label: "Name",
                hint: "Mo'men Yosri",
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                controller: nameController),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
                label: "Email",
                hint: "momen@developer.com",
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "email is required";
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text);
                  if (!emailValid) {
                    return "please enter a valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,isPassword: true,),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
                label: "Password",
                hint: "",
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "password is required";
                  } else if (text.trim().length < 8) {
                    return "password must be at least 8 characters";
                  } else {
                    return null;
                  }
                },
                controller: passController,isPassword: true,),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormField(
                label: "Confirm Password",
                hint: "",
                validator: (text) {
                  if (text != passController.text) {
                    return "passwords do not match";
                  } else {
                    return null;
                  }
                },
                controller: confirmController),
            SizedBox(
              height: 36.h,
            ),
            SizedBox(
                width: 144.w,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    validateForm();
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(AppColors.primaryColor),
                  ),
                )),
          ]),
        ),
      ),
    );
  }

  void validateForm(){
  if (_formKey.currentState!.validate() ){
viewModel.register(emailController.text,
                      passController.text, _formKey, nameController.text); }
  else{
    print("Form validation failed.");
  }
 }
   @override

  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
   showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor,),
          );
        });
  }

  @override
  void showMessage(String message, bool isSuccess) {
    CustomSnackBar.show(context,message: message, isSuccess: isSuccess);
  }

  @override
  void navigateToHome(UserModel user) {
//! listen must be false  
    //!because the provider used outside the build
     var userProvider = Provider.of<UserProvider>(context, listen: false);
     userProvider.user = user;
      Navigator.of(context).pushNamed(HomeScreenView.routeName);
   }
}

