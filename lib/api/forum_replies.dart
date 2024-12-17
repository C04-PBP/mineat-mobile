// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<ForumReplies> forumRepliesFromJson(String str) => List<ForumReplies>.from(json.decode(str).map((x) => ForumReplies.fromJson(x)));

String forumRepliesToJson(List<ForumReplies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumReplies {
    int id; 
    String user;
    String text;
    String timeCreated;

    ForumReplies({
        required this.id,
        required this.user,
        required this.text,
        required this.timeCreated,
    });

    factory ForumReplies.fromJson(Map<String, dynamic> json) => ForumReplies(
        id: json["id"],
        user: json["user"],
        text: json["text"],
        timeCreated: json["time_created"],
    );

    Map<String, dynamic> toJson() => {
        "id": id, 
        "user": user,
        "text": text,
        "time_created": timeCreated,
    };
}