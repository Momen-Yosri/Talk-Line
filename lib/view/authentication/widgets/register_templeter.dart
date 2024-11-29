import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';
import 'package:talk_line/view/authentication/widgets/custom_form_field.dart';
import 'package:talk_line/view/home_screen/home_screen.dart';

class RegisterTemplate extends StatefulWidget {

   RegisterTemplate({super.key});

  @override
  State<RegisterTemplate> createState() => _RegisterTemplateState();
}

class _RegisterTemplateState extends State<RegisterTemplate> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
      
            backgroundColor:Color(0xffF0F0F0),
            child: Icon(Icons.person,size: 50.r,color: Colors.white,),
          ),
          SizedBox(height:20.h),
        CustomTextFormField(label: "Name", hint: "Mo'men Yosri", validator: (text){ if (text == null || text.trim().isEmpty) {
                return "Name is required";
              }
              return null;}, controller: nameController),
        SizedBox(height: 20.h,),
        CustomTextFormField(label: "Email", hint: "momen@developer.com", validator:  (text){if(text==null||text.trim().isEmpty){
                  return "email is required";
                }
                final bool emailValid = 
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
                 if(!emailValid){
                  return "please enter a valid email";
                }
                else 
                {return null;}}, controller: emailController),
              SizedBox(height: 20.h,),
        CustomTextFormField(label: "Password", hint: "", validator:  (text){if(text==null||text.trim().isEmpty){
                  return "password is required";
                }
                else if(text.trim().length<8){
                  return "password must be at least 8 characters";
                }
                else 
                {return null;}}, controller: passController),
              SizedBox(height: 20.h,),
        CustomTextFormField(label: "Confirm Password", hint: "", validator:  (text){
          if(text!=passController.text) {return "passwords do not match";}
          else {return null;}
        }, controller: confirmController),
        SizedBox(
                height: 36.h,
              ),
              SizedBox(
                width:144.w ,
                height: 50.h,
                child: ElevatedButton(onPressed: (){print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
                  register();}, child: const Text("Register",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),),)),
            
        ]
      ),
    );
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        print(credential.user!.email);
        print(credential.user!.uid);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print("Registration error: $e");
      }
    } else {
      print("Form validation failed.");
    }
  }
}