import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? image;
  String? backgroundImage;
  String? email;
  String? userName;
  String? name;
  String? id;
  String? bio;
  String? password;
  String? seeName;
  int? rozetId;
  UserModel(
    this.image,
    this.backgroundImage,
    this.email,
    this.userName,
    this.name,
    this.id,
    this.bio,
    this.password,
    this.seeName, {
    this.rozetId,
  });

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(image != null){
      result.addAll({'image': image});
    }
    if(backgroundImage != null){
      result.addAll({'backgroundImage': backgroundImage});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(userName != null){
      result.addAll({'userName': userName});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(id != null){
      result.addAll({'id': id});
    }
    if(bio != null){
      result.addAll({'bio': bio});
    }
    if(password != null){
      result.addAll({'password': password});
    }
    if(seeName != null){
      result.addAll({'seeName': seeName});
    }
    if(rozetId != null){
      result.addAll({'rozetId': rozetId});
    }
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['image'],
      map['backgroundImage'],
      map['email'],
      map['userName'],
      map['name'],
      map['id'],
      map['bio'],
      map['password'],
      map['seeName'],
    
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
