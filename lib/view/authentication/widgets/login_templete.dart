import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';
import 'package:talk_line/view/authentication/widgets/custom_form_field.dart';
import 'package:talk_line/view/home_screen/home_screen.dart';

class LoginTemplate extends StatefulWidget {
  const LoginTemplate({super.key});

  @override
  State<LoginTemplate> createState() => _LoginTemplateState();
}

class _LoginTemplateState extends State<LoginTemplate> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? emailError;
  String? passwordError;

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateEmail(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        emailError = "Email is required";
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
          .hasMatch(value)) {
        emailError = "Please enter a valid email";
      } else {
        emailError = null;
      }
    });
  }

  void validatePassword(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        passwordError = "Password is required";
      } else if (value.trim().length < 6) {
        passwordError = "Password must be at least 6 characters";
      } else {
        passwordError = null;
      }
    });
  }

  void login() async {
    if (emailError == null && passwordError == null) {
      setState(() {
        isLoading = true;
      });

      try {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("Logged in User ID: ${userCredential.user?.uid}");
        Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is invalid.';
        } else {
          message = 'An error occurred: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        CustomTextFormField(
          hint: "momen@developer.com",
          label: "Email",
          controller: emailController,
          validator: (_) => emailError,
        ),
        if (emailError != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              emailError!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
        SizedBox(height: 20.h),
        CustomTextFormField(
          hint: "",
          label: "Password",
          controller: passwordController,
          validator: (_) => passwordError,
        ),
        if (passwordError != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              passwordError!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
        SizedBox(height: 36.h),
        SizedBox(
          width: 144.w,
          height: 50.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : login,
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : const Text("Login", style: TextStyle(color: Colors.white)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            ),
          ),
        ),
      ]),
    );
  }
}
