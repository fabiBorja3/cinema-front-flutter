// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.id,
        this.password,
        this.username,
    });

    int id;
    String password;
    String username;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        password: json["password"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "username": username,
    };
}
