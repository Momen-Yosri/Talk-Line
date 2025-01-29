class MessageModel {
  static const String collectionName = 'messages';
  String messageID;
  String roomID;
  String messageContent;
  String senderName;
  String senderID;
  int dateTime;
  MessageModel(
      {this.messageID = '',
      required this.roomID,
      required this.messageContent,
      required this.senderName,
      required this.senderID,
      required this.dateTime});

  MessageModel.fromJson(Map<String, dynamic> json)
      : this(
            messageID: json['messageID'] as String,
            roomID: json['roomID'] as String,
            messageContent: json['messageContent'] as String,
            senderName: json['senderName'] as String,
            senderID: json['senderID'] as String,
            dateTime: json['dateTime'] as int);
  Map<String, dynamic> toJson() {
    return {
      'messageID': messageID,
      'roomID': roomID,
      'messageContent': messageContent,
      'senderName': senderName,
      'senderID': senderID,
      'dateTime': dateTime,
    };
  }
}
