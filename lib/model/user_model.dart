class UserModel {
  static const String collectionName = 'users';
  String? name;
  String? email;
   String? id;
  UserModel({required this.name, required this.email, required String id});
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
        name: json['name'] as String,
       email: json['password'] as String,
      id : json['id'] as String);


  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email,'id':id};
  }
}