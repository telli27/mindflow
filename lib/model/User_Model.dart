import 'dart:convert';

class GetUserModel {
  String userName;
  String email;
  String id;
  String image;
  String seeName;
  int? rozetId;
  GetUserModel({
    required this.userName,
    required this.email,
    required this.id,
    required this.image,
    required this.seeName,
     this.rozetId,
  });



  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userName': userName});
    result.addAll({'email': email});
    result.addAll({'id': id});
    result.addAll({'image': image});
    result.addAll({'seeName': seeName});
    result.addAll({'rozetId': rozetId});
  
    return result;
  }

  factory GetUserModel.fromMap(Map<String, dynamic> map) {
    return GetUserModel(
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      seeName: map['seeName'] ?? '',
      rozetId: map['rozetId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUserModel.fromJson(String source) => GetUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetUserModel(userName: $userName, email: $email, id: $id, profileImage: $image, seeName: $seeName)';
  }
}
