// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool success;
  String message;
  Data data;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  User user;
  String token;
  String tokenType;

  Data({
    required this.user,
    required this.token,
    required this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
    "token_type": tokenType,
  };
}

class User {
  int id;
  String email;
  String role;
  bool isFirstTime;
  String subscriptionType;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.isFirstTime,
    required this.subscriptionType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    role: json["role"],
    isFirstTime: json["is_first_time"],
    subscriptionType: json["subscription_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role,
    "is_first_time": isFirstTime,
    "subscription_type": subscriptionType,
  };
}
