import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smartfarm/models/sensor_model.dart';
import 'package:smartfarm/services/api_services.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;
  TextController con = TextController();
  List<SensorModels> sensorValue = List<SensorModels>();
  List<InputValue> inputValue = List<InputValue>();
  List<double> data = [];
  Map<DateTime, double> datas = {};

  @override
  void initState() {
    setState(() {
      fetchSensor();
    });

    super.initState();
  }

  // fetchValue(){
  //   ApiServices().getInputValuesChart("nodeM1", uid)
  // }
  fetchSensor() {
    ApiServices().getSensor("nodeM1").then((value) {
      setState(() {
        sensorValue.addAll(value);
        setState(() {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
  }

  dataList() {
    List<dynamic> list = [];
    try {
      for (dynamic model in sensorValue[0].inputValue) {
        setState(() {
          data.add(double.parse(sensorValue[0]
                  .inputValue[sensorValue[0].inputValue.indexOf(model)]
                  .timestamp) ??
              25.91);
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  List<double> timestamp() {
    List<double> list = [];
    try {
      for (var index = 0; index < sensorValue[0].inputValue.length; index++) {
        list.add(double.parse(sensorValue[0].inputValue[index].timestamp));
      }
      return list;
    } catch (e) {
      print("Error");
      print(e);
      return null;
    }
  }

  Map<DateTime, double> chartLine() {
    try {
      Map<DateTime, double> map = {};
      List<Map<DateTime, double>> list = [];
      for (var index = 0; index < sensorValue[0].inputValue.length; index++) {
        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(sensorValue[0].inputValue[index].timestamp));
        var hour = DateFormat('Hm').format(date);

        map[date] = double.parse(sensorValue[0].inputValue[index].temperature);

        list.add(
            {date: double.parse(sensorValue[0].inputValue[index].temperature)});
      }
      print(list);
      return map;
    } catch (e) {
      print("Error");
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff23475A),
          toolbarHeight: 90,
          centerTitle: true,
          title: Text(
            "DashBoard",
            style: GoogleFonts.kanit(fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [],
                  ),
                ],
              ));
  }
}
