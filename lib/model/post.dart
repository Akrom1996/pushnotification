// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.name,
    this.surname,
    this.time,
    this.message,
  });

  final String? id;
  final String? name;
  final String? surname;
  final String? time;
  final String? message;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        time: json["time"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "time": time,
        "message": message,
      };
}
