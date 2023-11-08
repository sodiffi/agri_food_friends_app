// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';
// import 'dart:html';

List<Event> parseEvents(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
    Event({
        required this.title,
        required this.user_id,
        required this.create_time,
        required this.content,
        this.msg=const[],
        this.id=0
    });

    String title;
    String user_id;
    String create_time;
    String content;
    int id;
    List<Msg> msg;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
      id:json["id"],
        title: json["title"],
        user_id: json["user_id"],
        create_time: json["create_time"],
        content: json["content"],
        msg: json["msg"].length!=0?List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))):[],
        // msg:[]
    );

    Map<String, dynamic> toJson() => {
      
        "title": title,
        "user_id": user_id,
        "create_time": create_time,
        "content": content,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    };
}

class Msg {
    Msg({
        required this.user_id,
        required this.time,
        required this.content,
        // required this.article_id,
    });

    String user_id;
    String time;
    String content;
    // int article_id;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        user_id: json["user_id"] == null ? null : json["user_id"],
        time: json["time"] == null ? "null" : json["time"],
        content: json["content"] == null ? null : json["content"],
        // article_id: json['article_id']==null?null:json["article_id"]
    );

    Map<String, dynamic> toJson() => {
        "user_id": user_id == null ? null : user_id,
        "time": time == null ? null : time,
        "content": content == null ? null : content,
        // "article_id":article_id== null ? null : article_id,
    };
}
