import 'package:talk_line/core/model/user_model.dart';
import 'package:talk_line/core/provider/user_provider.dart';
import 'package:talk_line/features/genrals/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:talk_line/core/style/app_colors.dart';
import 'package:talk_line/features/authentication/login/login_navigator.dart';
import 'package:talk_line/features/authentication/login/login_view_model.dart';
import 'package:talk_line/features/authentication/widgets/custom_form_field.dart';
import 'package:talk_line/features/home_screen/home_screen_view.dart';

class LoginTemplate extends StatefulWidget {

   LoginTemplate({super.key});

  @override
  State<LoginTemplate> createState() => _LoginTemplateState();
}

class _LoginTemplateState extends State<LoginTemplate> implements LoginNavigator {
   final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginViewModel viewModel = LoginViewModel();
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
        child: Column(children: [
            CustomTextFormField(validator:(text){
                  if(text==null||text.trim().isEmpty){
                    return "email is required";
                  }
                  final bool emailValid = 
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                    print("password is required");
                    return "password is required";
                  }
                  else if(text.trim().length<8){
                    return "password must be at least 8 characters";
                  }
                  else 
                  {return null;}
                } ,hint: "",label:"password" ,controller: passwordController,isPassword: true,),
                SizedBox(
                  height: 36.h,
                ),
                SizedBox(
                  width:144.w ,
                  height: 50.h,
                  child: ElevatedButton(onPressed: (){
                    validateForm();
                    
                  }, child: const Text("Login",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),),)),
              
        ]),
      ),
    );
    
  }
 void validateForm(){
    if(_formKey.currentState?.validate() == true){
      
      viewModel.login(emailController.text, passwordController.text);
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
      Navigator.of(context).pushReplacementNamed(HomeScreenView.routeName);
  }
}