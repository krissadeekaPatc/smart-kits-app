// To parse this JSON data, do
//
//     final inputValueModels = inputValueModelsFromJson(jsonString);

import 'dart:convert';

List<InputValueModels> inputValueModelsFromJson(String str) => List<InputValueModels>.from(json.decode(str).map((x) => InputValueModels.fromJson(x)));

String inputValueModelsToJson(List<InputValueModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InputValueModels {
    InputValueModels({
        this.temperature,
        this.humidity,
        this.light,
        this.timestamp,
    });

    String temperature;
    String humidity;
    String light;
    String timestamp;

    factory InputValueModels.fromJson(Map<String, dynamic> json) => InputValueModels(
        temperature: json["temperature"],
        humidity: json["humidity"],
        light: json["light"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
        "light": light,
        "timestamp": timestamp,
    };
}
