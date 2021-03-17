// To parse this JSON data, do
//
//     final sensorModels = sensorModelsFromJson(jsonString);

import 'dart:convert';

List<SensorModels> sensorModelsFromJson(String str) => List<SensorModels>.from(json.decode(str).map((x) => SensorModels.fromJson(x)));

String sensorModelsToJson(List<SensorModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SensorModels {
    SensorModels({
        this.id,
        this.uid,
        this.devicename,
        this.inputValue,
        this.d1,
        this.d2,
        this.d5,
        this.d6,
        this.automation,
        this.dataChart,
    });

    String id;
    String uid;
    String devicename;
    List<InputValue> inputValue;
    String d1;
    String d2;
    String d5;
    String d6;
    String automation;
    List<DataChart> dataChart;

    factory SensorModels.fromJson(Map<String, dynamic> json) => SensorModels(
        id: json["_id"],
        uid: json["uid"],
        devicename: json["devicename"],
        inputValue: List<InputValue>.from(json["inputValue"].map((x) => InputValue.fromJson(x))),
        d1: json["D1"],
        d2: json["D2"],
        d5: json["D5"],
        d6: json["D6"],
        automation: json["automation"],
        dataChart: List<DataChart>.from(json["data_chart"].map((x) => DataChart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uid": uid,
        "devicename": devicename,
        "inputValue": List<dynamic>.from(inputValue.map((x) => x.toJson())),
        "D1": d1,
        "D2": d2,
        "D5": d5,
        "D6": d6,
        "automation": automation,
        "data_chart": List<dynamic>.from(dataChart.map((x) => x.toJson())),
    };
}

class DataChart {
    DataChart({
        this.temperature,
        this.timestamp,
    });

    String temperature;
    String timestamp;

    factory DataChart.fromJson(Map<String, dynamic> json) => DataChart(
        temperature: json["temperature"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "timestamp": timestamp,
    };
}

class InputValue {
    InputValue({
        this.temperature,
        this.humidity,
        this.light,
        this.timestamp,
    });

    String temperature;
    String humidity;
    String light;
    String timestamp;

    factory InputValue.fromJson(Map<String, dynamic> json) => InputValue(
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