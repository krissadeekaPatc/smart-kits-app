// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
    this.id,
    this.uid,
    this.username,
    this.email,
    this.password,
    this.birthdate,
    this.gender,
    this.phone,
  });

  String id;
  String uid;
  String username;
  String email;
  String password;
  String birthdate;
  String gender;
  String phone;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["_id"],
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "username": username,
        "email": email,
        "password": password,
        "birthdate": birthdate,
        "gender": gender,
        "phone": phone,
      };
}
