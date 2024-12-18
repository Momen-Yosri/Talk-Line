import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_line/features/authentication/login/login_navigator.dart';
import 'package:talk_line/core/model/data_base.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void login(
    String email,
    String password,
  ) async {
    navigator.showLoading();
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          
      print(result.user?.uid ?? "");

      // to retrieve data
      var userObject = await DataBaseUtils.getUser(result.user!.uid);
      if (userObject == null) {
        navigator.hideLoading();
        navigator.showMessage('Login  failed try again ', false);
      } else {
        navigator.hideLoading();
        print("login");
        navigator.showMessage('Login Successfully', true);
        navigator.navigateToHome(userObject);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideLoading();
        navigator.showMessage('No user found for that email.', false);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideLoading();
        navigator.showMessage('Wrong password provided for that user.', false);
        // hide loading
        print('Wrong password provided for that user.');
      }
    }
  }
}
