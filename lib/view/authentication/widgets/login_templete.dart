import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_line/app_colors.dart';
import 'package:talk_line/view/authentication/widgets/custom_form_field.dart';

class LoginTemplate extends StatelessWidget {
   final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
   LoginTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
          CustomTextFormField(validator:(text){
                if(text==null||text.trim().isEmpty){
                  return "email is required";
                }
                final bool emailValid = 
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
                 if(!emailValid){
                  return "please enter a valid email";
                }
                else 
                {return null;}
        
          } ,hint:"momen@developer.com" ,label:"email" ,controller: emailController,),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(validator:(text){
                if(text==null||text.trim().isEmpty){
                  return "password is required";
                }
                else if(text.trim().length<8){
                  return "password must be at least 8 characters";
                }
                else 
                {return null;}
              } ,hint: "",label:"password" ,controller: passwordController,),
              SizedBox(
                height: 36.h,
              ),
              SizedBox(
                width:144.w ,
                height: 50.h,
                child: ElevatedButton(onPressed: (){}, child: const Text("Login",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),),)),
            
      ]),
    );
  }
}