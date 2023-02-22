// To parse this JSON data, do
//
//     final userResponse = userResponseFromMap(jsonString);

import 'dart:convert';

import 'package:chat/models/user.dart';

UserResponse userResponseFromMap(String str) => UserResponse.fromMap(json.decode(str));

String userResponseToMap(UserResponse data) => json.encode(data.toMap());

class UserResponse {
    UserResponse({
        required this.ok,
        required this.users, 
    });

    bool ok;
    List<User> users; 

    factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromMap(x))), 
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toMap())), 
    };
}
  