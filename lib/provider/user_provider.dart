import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_line/model/data_base.dart';
import 'package:talk_line/model/user_model.dart';
// this class is used to save user info
class UserProvider extends ChangeNotifier {
  UserModel? user;
  User? firebaseUser;
  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    // intializing the user
    initUser();
  }

  initUser() async {// to cheack if hte user exist in fire base or not
    if (firebaseUser != null) {// act as validator
      user = await DataBaseUtils.getUser(firebaseUser!.uid );
    }
  }
}
