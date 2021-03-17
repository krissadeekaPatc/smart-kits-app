import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/models/chartData.dart';
import 'package:smartfarm/models/inputValue_models.dart';
import 'dart:convert';

import 'package:smartfarm/models/sensor_model.dart';
import 'package:smartfarm/models/users_model.dart';

List<UsersModel> usersModelSingleton = List<UsersModel>();

class ApiServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var urlSensor =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/sensorget";
  var urlSensorAll =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/sensorget/all";

  var urlUsers =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/userget";

  var urlUserPost =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/userpost";
  var controlStateUrl =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/control";

  var urlChartData =
      "https://us-central1-smartfarmkits.cloudfunctions.net/explore/sensorget/chart";

  Future<List<SensorModels>> getSensor(String devicename) async {
    var response = await http.get(urlSensor, headers: {
      "uid": _auth.currentUser.uid,
      "devicename": devicename,
    });
    if (response.statusCode == 200) {
      List<SensorModels> list = [];
      var data = json.decode(response.body);

      for (var sensors in data) {
        list.add(SensorModels.fromJson(sensors));
      }
      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<SensorModels>> getAllSensor() async {
    var response = await http.get(urlSensorAll, headers: {
      "uid": _auth.currentUser.uid,
    });
    if (response.statusCode == 200) {
      List<SensorModels> list = [];
      var data = json.decode(response.body);

      for (var sensors in data) {
        list.add(SensorModels.fromJson(sensors));
      }
      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<InputValueModels>> getInputValuesChart(String devicename) async {
    var response = await http.get(
        "https://us-central1-smartfarmkits.cloudfunctions.net/explore/sensorget/test",
        headers: {
          "uid": _auth.currentUser.uid,
          "devicename": devicename,
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<InputValueModels> list = [];
      for (var sensors in data) {
        list.add(InputValueModels.fromJson(sensors));
      }
      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<ChartData>> getChart(String devicename) async {
    var response = await http.get(urlChartData, headers: {
      "uid": _auth.currentUser.uid,
      "devicename": devicename,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ChartData> list = [];
      for (var chart in data) {
        list.add(ChartData.fromJson(chart));
      }
      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<InputValueModels>> getInputValues(String devicename) async {
    var response = await http.get(
        "https://us-central1-smartfarmkits.cloudfunctions.net/explore/sensorget/last",
        headers: {
          "uid": _auth.currentUser.uid,
          "devicename": devicename,
        });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<InputValueModels> list = [];
      for (var sensors in data) {
        list.add(InputValueModels.fromJson(sensors));
      }
      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<UsersModel>> getUsersModel() async {
    var response = await http.get(urlUsers, headers: {
      "uid": _auth.currentUser.uid,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var usersData in data) {
        usersModelSingleton.add(UsersModel.fromJson(usersData));
      }
      return usersModelSingleton;
    } else {
      throw Exception();
    }
  }

  Future<List<SensorModels>> setStatus(
    String devicename,
    String channel,
    bool status,
  ) async {
    // print("$uid $devicename $status");

    var response = await http.post(
      controlStateUrl,
      headers: {
        "uid": _auth.currentUser.uid,
        "devicename": devicename,
      },
      body: {
        "channel": channel,
        "status": "$status",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return null;
    } else {
      return null;
    }
  }

  Future<List<SensorModels>> setPwm(
    String devicename,
    String channel,
    double pwm,
  ) async {
    // print("$uid $devicename $status");

    var response = await http.post(
      controlStateUrl,
      headers: {
        "uid": _auth.currentUser.uid,
        "devicename": devicename,
      },
      body: {
        "channel": channel,
        "status": "$pwm",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return null;
    } else {
      return null;
    }
  }

  Future<List<UsersModel>> createUsers(
      String username,
      String phone,
      String email,
      String gender,
      String birthdate,
      String password,
      String token) async {
    try {
      var response = await http.post(urlUserPost, headers: {
        "authorization": token,
        "uid": _auth.currentUser.uid,
      }, body: {
        "uid": _auth.currentUser.uid,
        "username": username,
        "password": password,
        "phone": phone ?? "Not Set",
        "email": email ?? "NULL",
        "gender": gender ?? "Not set",
        "birthdate": birthdate ?? "Not set"
      });

      if (response.statusCode == 200) {
        final String resString = response.body;

        return usersModelFromJson(resString);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
