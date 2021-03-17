// To parse this JSON data, do
//
//     final chartData = chartDataFromJson(jsonString);

import 'dart:convert';

List<ChartData> chartDataFromJson(String str) =>
    List<ChartData>.from(json.decode(str).map((x) => ChartData.fromJson(x)));

String chartDataToJson(List<ChartData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartData {
  ChartData({
    this.temperature,
    this.humidity,
    this.light,
    this.timestamp,
  });

  String temperature;
  String humidity;
  String light;
  String timestamp;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        temperature: json["temperature"] == null ? null : json["temperature"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        light: json["light"] == null ? null : json["light"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature == null ? null : temperature,
        "humidity": humidity == null ? null : humidity,
        "light": light == null ? null : light,
        "timestamp": timestamp,
      };
}
