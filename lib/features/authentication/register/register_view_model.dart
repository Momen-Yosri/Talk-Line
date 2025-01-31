import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talk_line/core/utils/data_base.dart';
import 'package:talk_line/core/model/user_model.dart';
import 'package:talk_line/features/authentication/register/register_navigator.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

   void register( String email, String password,  _formKey,  String name, String selectedAvatar) async {
        navigator.showLoading();
      try {
        print("Attempting to register with email: $email");

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email, password: password);
                if (userCredential.user == null) {
            throw Exception("Firebase Auth did not return a valid user.");
        }
                var userID =userCredential.user!.uid;
                                print("Registration successful, UID: $userID");
        UserModel user = UserModel(name: name, email: email, id: userID, avatar:selectedAvatar);
        print(user.email);
        print(user.name);
        print(user.id);
                 await DataBaseUtils.registerUser(user);
navigator.hideLoading();
navigator.showMessage("Registration successful, UID: ${userCredential.user?.uid ?? ""}", true);
navigator.navigateToHome(user);
        

       
      } on FirebaseAuthException catch (e) { 
        if (e.code == 'weak-password') {
           navigator.hideLoading();
    navigator.showMessage('The password provided is too weak.',false);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
                          navigator.hideLoading();
    navigator.showMessage('The account already exists for that email.',false);
        }
      } catch (e) {
         navigator.hideLoading();
    navigator.showMessage('Registration error: $e',false);
        print("Registration error: $e");
      }
    
  }
}