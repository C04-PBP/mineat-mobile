// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) => List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
    int id;
    String user;
    String title;
    String timeCreated;
    String text;

    Forum({
        required this.id,
        required this.user,
        required this.title,
        required this.timeCreated,
        required this.text,
    });

    factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        id: json["id"],
        user: json["user"],
        title: json["title"],
        timeCreated: json["time_created"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "title": title,
        "time_created": timeCreated,
        "text": text,
    };
}