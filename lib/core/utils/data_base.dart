import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talk_line/core/model/message_model.dart';
import 'package:talk_line/core/model/room_model.dart';
import 'package:talk_line/core/model/user_model.dart';

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

  static Future<UserModel?> getUser(String userId) async {
    var userDocSnapshot = await getUserCollection().doc(userId).get();
    return userDocSnapshot.data();
  }

  // function to get collectoin of room
  static CollectionReference<RoomModel> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(RoomModel.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                RoomModel.fromJson(snapshot.data()!),
            toFirestore: (room, options) => room.toJson());
  }

  // function to create a new room
  static Future<void> createRoom(RoomModel room) async {
    var roomDocumentReference = getRoomCollection().doc();
    room.roomId = roomDocumentReference.id;
    return roomDocumentReference.set(room);
  }

  // function to get a stream of rooms
  static Stream<QuerySnapshot<RoomModel>> getRooms() {
    return getRoomCollection().snapshots();
  }

//
  static CollectionReference<MessageModel> getMessageCollection(String roomID) {
    return FirebaseFirestore.instance
        .collection(RoomModel.collectionName)
        .doc(roomID)
        .collection(MessageModel.collectionName)
        .withConverter<MessageModel>(
            fromFirestore: (snapshot, options) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (message, options) => message.toJson());
  }

  // function to insert a new message
  static Future<void> insertMessage(MessageModel message) async {
    var messageCollection = getMessageCollection(message.roomID);
    var documentReference = messageCollection.doc(); // to create a new document inside the collection
    //!This creates a new document inside the specified collection without providing a document ID.
    //! Firestore automatically generates a unique ID for this document.
    message.messageID = documentReference.id;
    return documentReference.set(message); //!This saves the message object as a new document in Firestore at the documentReference location.
  }
 
}
