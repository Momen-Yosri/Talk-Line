import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talk_line/model/user_model.dart';

class DataBaseUtils {
  static CollectionReference<UserModel> getRegisteredUser() {
   return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter(
            fromFirestore: (snapShot, options) =>
                UserModel.fromJson(snapShot.data()!),
            toFirestore: (user, options) => user.toJson());
    // Register user
  }
  static Future<void> registerUser(UserModel user)async{
   return  getRegisteredUser().doc(user.id).set(user);
  } 
}
