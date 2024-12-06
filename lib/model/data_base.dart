import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talk_line/model/user_model.dart';

class DataBaseUtils {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel
            .collectionName) // function returns a collection reference of <R>
        .withConverter(
            // function converts the collection reference to a collection reference of <T>
            fromFirestore: (snapShot, options) =>
                UserModel.fromJson(snapShot.data()!),
            toFirestore: (user, options) => user.toJson());
    // Register user
  }

  static Future<void> registerUser(UserModel user) async {
    // function
    return getUserCollection()
        .doc(user.id)
        .set(user); // user id generated from authentication
    //and use this id as id of a document
  }

static Future<UserModel?> getUser (String userId) async {
    var userDocSnapshot =await getUserCollection().doc(userId).get();
    return userDocSnapshot.data();
  }
}
