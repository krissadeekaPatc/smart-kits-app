import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/models/chartData.dart';
import 'package:smartfarm/screen/widget/animated_button.dart';
import 'package:smartfarm/screen/widget/primary_button.dart';
import 'package:smartfarm/services/api_services.dart';

class LineChartSample1 extends StatefulWidget {
  final String devicename;

  const LineChartSample1({Key key, this.devicename}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  int state = 1;
  bool isShowingMainData;
  bool isLoading = true;
  TextController con = TextController();
  List<ChartData> sensorValue = List<ChartData>();

  String dateName = DateFormat('EEEE').format(DateTime.now());
  String date = DateFormat('d').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());
  String year = DateFormat('y').format(DateTime.now());

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  String datetimeFormat(String date) {
    var format = DateTime.fromMillisecondsSinceEpoch(
        (int.parse(date) + 25200) * 1000,
        isUtc: true);
    var result = DateFormat('Hm').format(format);

    return result;
  }

  TextStyle style1 = GoogleFonts.kanit(
      fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle style2 = GoogleFonts.kanit(fontSize: 22, color: Colors.grey[800]);
  Timer a;
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    setState(() {
      fetchSensor();
    });
    a = Timer.periodic(Duration(seconds: 1), (t) => fetchSensor());
  }

  @override
  void dispose() {
    a.cancel();
    super.dispose();
  }

  fetchSensor() {
    ApiServices().getChart(widget.devicename).then((value) {
      setState(() {
        sensorValue.clear();
        setState(() {
          sensorValue.addAll(value);
          setState(() {
            isLoading = false;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color(0xffF6F6F6),
                          Color(0xffF6F6F6),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff22475A),
                                offset: Offset(-5, 0)),
                          ],
                        ),
                        child: Card(
                          elevation: 20,
                          color: Colors.white,
                          // shadowColor: Colors.red,
                          margin: EdgeInsets.only(left: 20),
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(27.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      dateName,
                                      style: style1,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      date,
                                      style: style1,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      month,
                                      style: style2,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      year,
                                      style: style2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              buildLineChart1(),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff486CA5).withOpacity(0.8),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child:

                                    // AnimatedButton(
                                    //   iconData: Icons.close,
                                    //   iconSize: 30,
                                    //   finalText: "Exited!",
                                    //   initialText: "Exit",
                                    //   animationDuration:
                                    //       Duration(milliseconds: 500),
                                    //   onTap: () {
                                    //     Navigator.pop(context);
                                    //   },
                                    //   buttonStyle: ButtonStyle(
                                    //     primaryColor: Colors.blue.shade600,
                                    //     secondaryColor: Colors.white,
                                    //     elevation: 20.0,
                                    //     initialTextStyle: TextStyle(
                                    //       fontSize: 22.0,
                                    //       color: Colors.white,
                                    //     ),
                                    //     finalTextStyle: TextStyle(
                                    //       fontSize: 22.0,
                                    //       color: Colors.blue.shade600,
                                    //     ),
                                    //     borderRadius: 30.0,
                                    //   ),
                                    // )

                                    PrimaryButton(
                                  width: 120,
                                  height: 50,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff486CA5),
                                      Color(0xff0F3447),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  radius: 30,
                                  child: Text(
                                    "Exit",
                                    style: GoogleFonts.kanit(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  AspectRatio buildLineChart1() {
    return AspectRatio(
      aspectRatio: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff0F3447),
              Color(0xff486CA5),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Today Chart.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state == 1
                      ? 'Temperature'
                      : state == 2
                          ? "Humidity"
                          : state == 3
                              ? "Light"
                              : null,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      state == 1
                          ? sampleData1()
                          : state == 2
                              ? sampleData2()
                              : state == 3
                                  ? sampleData3()
                                  : null,
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.swap_horiz,
                size: 40,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                if (state == 1) {
                  setState(() {
                    state = 2;
                  });
                } else if (state == 2) {
                  setState(() {
                    state = 3;
                  });
                } else if (state == 3) {
                  setState(() {
                    state = 1;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 23,
          getTextStyles: (value) => TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return datetimeFormat(sensorValue[0].timestamp);
              case 2:
                return datetimeFormat(sensorValue[1].timestamp);
              case 3:
                return datetimeFormat(sensorValue[2].timestamp);
              case 4:
                return datetimeFormat(sensorValue[3].timestamp);
              case 5:
                return datetimeFormat(sensorValue[4].timestamp);
              case 6:
                return datetimeFormat(sensorValue[5].timestamp);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: 6.5,
      maxY: 35,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, double.parse(sensorValue[0].temperature)),
        FlSpot(2, double.parse(sensorValue[1].temperature)),
        FlSpot(3, double.parse(sensorValue[2].temperature)),
        FlSpot(4, double.parse(sensorValue[3].temperature)),
        FlSpot(5, double.parse(sensorValue[4].temperature)),
        FlSpot(6, double.parse(sensorValue[5].temperature)) ?? null,
      ],
      isCurved: true,
      colors: [
        Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          ColorTween(begin: Colors.green, end: Colors.green.shade300)
              .lerp(0.2)
              .withOpacity(0.1),
          ColorTween(begin: Colors.green, end: Colors.green.shade300)
              .lerp(0.2)
              .withOpacity(0.4),
        ],
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, double.parse(sensorValue[0].humidity)),
        FlSpot(2, double.parse(sensorValue[1].humidity)),
        FlSpot(3, double.parse(sensorValue[2].humidity)),
        FlSpot(4, double.parse(sensorValue[3].humidity)),
        FlSpot(5, double.parse(sensorValue[4].humidity)),
        FlSpot(6, double.parse(sensorValue[5].humidity)),
      ],
      isCurved: true,
      colors: [
        // Color(0xff4af699),
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.1),
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.4),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, double.parse(sensorValue[0].light)),
        FlSpot(2, double.parse(sensorValue[1].light)),
        FlSpot(3, double.parse(sensorValue[2].light)),
        FlSpot(4, double.parse(sensorValue[3].light)),
        FlSpot(5, double.parse(sensorValue[4].light)),
        FlSpot(6, double.parse(sensorValue[5].light)),
      ],
      isCurved: true,
      colors: [
        // Color(0xff4af699),
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.1),
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.4),
      ]),
    );
    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData2() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return datetimeFormat(sensorValue[0].timestamp);
              case 2:
                return datetimeFormat(sensorValue[1].timestamp);
              case 3:
                return datetimeFormat(sensorValue[2].timestamp);
              case 4:
                return datetimeFormat(sensorValue[3].timestamp);
              case 5:
                return datetimeFormat(sensorValue[4].timestamp);
              case 6:
                return datetimeFormat(sensorValue[5].timestamp);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 20:
                return '20';
              case 40:
                return '40';
              case 60:
                return '60';
              case 80:
                return '80';
              case 100:
                return '100';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: 6.2,
      maxY: 100,
      minY: 0,
      lineBarsData: linesBarData2(),
    );
  }

  List<LineChartBarData> linesBarData2() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, double.parse(sensorValue[0].humidity)),
        FlSpot(2, double.parse(sensorValue[1].humidity)),
        FlSpot(3, double.parse(sensorValue[2].humidity)),
        FlSpot(4, double.parse(sensorValue[3].humidity)),
        FlSpot(5, double.parse(sensorValue[4].humidity)),
        FlSpot(6, double.parse(sensorValue[5].humidity)) ?? null,
      ],
      isCurved: true,
      colors: [
        // Color(0xff4af699),
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.1),
        ColorTween(begin: gradientColors[0], end: gradientColors[1])
            .lerp(0.2)
            .withOpacity(0.4),
      ]),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  LineChartData sampleData3() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return datetimeFormat(sensorValue[0].timestamp);
              case 2:
                return datetimeFormat(sensorValue[1].timestamp);
              case 3:
                return datetimeFormat(sensorValue[2].timestamp);
              case 4:
                return datetimeFormat(sensorValue[3].timestamp);
              case 5:
                return datetimeFormat(sensorValue[4].timestamp);
              case 6:
                return datetimeFormat(sensorValue[5].timestamp);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 200:
                return '200';
              case 400:
                return '400';
              case 600:
                return '600';
              case 800:
                return '800';
              case 1000:
                return '1000';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: 6.2,
      maxY: 1000,
      minY: 0,
      lineBarsData: linesBarData3(),
    );
  }

  List<LineChartBarData> linesBarData3() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, double.parse(sensorValue[0].light)),
        FlSpot(2, double.parse(sensorValue[1].light)),
        FlSpot(3, double.parse(sensorValue[2].light)),
        FlSpot(4, double.parse(sensorValue[3].light)),
        FlSpot(5, double.parse(sensorValue[4].light)),
        FlSpot(6, double.parse(sensorValue[5].light)),
      ],
      isCurved: true,
      colors: [
        // Color(0xff4af699),
        Colors.yellow[400]
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        ColorTween(begin: Colors.yellow[400], end: Colors.yellow)
            .lerp(0.2)
            .withOpacity(0.1),
        ColorTween(begin: Colors.yellow[400], end: Colors.yellow)
            .lerp(0.2)
            .withOpacity(0.4),
      ]),
    );
    return [
      lineChartBarData1,
    ];
  }
}
