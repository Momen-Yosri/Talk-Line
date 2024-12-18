class RoomModel {
  static const String collectionName = "rooms";
  String? roomId;
  String? roomName;
  String? roomDescription;
  RoomModel ({required this.roomId, required this.roomName, required this.roomDescription});
  RoomModel.fromJson(Map<String, dynamic> json): this 
      (roomId : json['roomId'] as String,
        roomName :json['roomName'],
        roomDescription : json['roomDescription']);
        Map<String, dynamic>toJson(){
return{
  'roomId': roomId,
  'roomName': roomName,
  'roomDescription': roomDescription,
};
        }
  
}