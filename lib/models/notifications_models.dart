// To parse this JSON data, do
//
//     final notificationsModels = notificationsModelsFromJson(jsonString);

import 'dart:convert';

List<NotificationsModels> notificationsModelsFromJson(String str) =>
    List<NotificationsModels>.from(
        json.decode(str).map((x) => NotificationsModels.fromJson(x)));

String notificationsModelsToJson(List<NotificationsModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsModels {
  NotificationsModels({
    this.title,
    this.body,
    this.data,
  });

  String title;
  String body;
  Data data;

  factory NotificationsModels.fromJson(Map<String, dynamic> json) =>
      NotificationsModels(
        title: json["title"],
        body: json["body"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
