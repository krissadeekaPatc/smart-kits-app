import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/home.dart';
import 'package:smartfarm/screen/widget/example.dart';
import 'package:smartfarm/screen/widget/primary_button.dart';
import 'package:smartfarm/screen/widget/switches.dart';
import 'package:smartfarm/services/api_services.dart';

class ControllerPage extends StatefulWidget {
  final String deviceName;
  String switchesD1;
  String switchesD2;
  String switchesD5;
  String switchesD6;
  String automation;
  ControllerPage({
    Key key,
    this.deviceName,
    this.switchesD1,
    this.switchesD2,
    this.switchesD5,
    this.switchesD6,
    this.automation,
  }) : super(key: key);
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage>
    with TickerProviderStateMixin {
  TextController con = TextController();
  bool switchesD1;
  bool switchesD2;
  bool switchesD5;
  bool switchesD6;
  bool automation;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _translationButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  List<Color> gradientActivate = [
    Colors.green,
    Colors.green,
  ];
  List<Color> gradientDeactivate = [
    Colors.red,
    Colors.red,
  ];
  double values;
  String uid;
  TextStyle styleDeviceName = GoogleFonts.kanit(fontSize: 30);

  @override
  void initState() {
    animationInit();

    setState(() {
      uid = FirebaseAuth.instance.currentUser.uid;
    });
    setState(() {
      switchesD1 = widget.switchesD1.parseBool() ?? false;
      switchesD2 = widget.switchesD2.parseBool() ?? false;
      switchesD5 = widget.switchesD5.parseBool() ?? false;
      values = double.parse(widget.switchesD6) ?? false;
      automation = widget.automation.parseBool() ?? false;
    });
    super.initState();
  }

  void animationInit() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _translationButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      heroTag: "null",
      backgroundColor: Color(0xff005C4F),
      onPressed: animate,
      autofocus: true,
      highlightElevation: 10,
      mini: false,
      child: Icon(
        Icons.menu,
        size: 40,
      ),
    );
  }

  Widget floatingGraph() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xff005C4F),
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LineChartSample1(
                devicename: widget.deviceName,
              ),
            ));
        setState(() {});
      },
      autofocus: true,
      highlightElevation: 10,
      mini: false,
      child: Icon(
        Icons.show_chart,
        size: 40,
      ),
    );
  }

  Widget floating3() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xff005C4F),
      onPressed: () {
        setState(() {
          automation = !automation;

          setState(() {
            ApiServices()
                .setStatus(widget.deviceName, "automation", automation);
          });
        });
      },
      autofocus: true,
      highlightElevation: 10,
      mini: false,
      child: Icon(
        automation ? Icons.pause : Icons.play_arrow,
        size: 40,
      ),
    );
  }

  Widget floating4() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xff005C4F),
      onPressed: () {
        Navigator.pop(context);
      },
      autofocus: true,
      highlightElevation: 10,
      mini: false,
      child: Icon(
        Icons.home,
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff005C4F),
        toolbarHeight: 90,
        centerTitle: true,
        title: Text(
          "Controller",
          style: GoogleFonts.kanit(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Device Name: ",
                style: styleDeviceName,
              ),
              Text(
                widget.deviceName,
                style: styleDeviceName,
              ),
            ],
          ),
          Column(
            children: [
              buildChannel1(),
              SizedBox(
                height: 10,
              ),
              buildChannel2(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 10,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 10),
                child: Row(
                  children: [
                    Text(
                      "PWM",
                      style: GoogleFonts.kanit(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                      child: CupertinoSlider(
                        activeColor: Color(0xff005C4F),
                        thumbColor: Color(0xff005C4F),
                        value: values,
                        onChanged: (value) {
                          setState(() {
                            values = value;
                            setState(() {
                              ApiServices()
                                  .setPwm(widget.deviceName, "D6", values);
                            });
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            values = value;
                            setState(() {
                              ApiServices()
                                  .setPwm(widget.deviceName, "D6", values);
                            });
                          });
                        },
                        max: 1023,
                        min: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // squareGird("assets/picture/garph.png", "Graph", context, 10, 10),
        ],
      )),
      floatingActionButton: buildFloating(),
    );
  }

  Column buildFloating() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform: Matrix4.translationValues(
              0.0, _translationButton.value * 3.0, 0.0),
          child: floating4(),
        ),
        Transform(
          transform: Matrix4.translationValues(
              0.0, _translationButton.value * 2.0, 0.0),
          child: floatingGraph(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translationButton.value, 0.0),
          child: floating3(),
        ),
        floatingActionButton()
      ],
    );
  }

  Widget squareGird(String picture, String menu, BuildContext context,
      double left, double right) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LineChartSample1(
                devicename: widget.deviceName,
              ),
            ));
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, left: 10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
            elevation: 5,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: Padding(
              padding: EdgeInsets.only(left: left, right: right),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    menu,
                    style: GoogleFonts.kanit(
                        fontSize: 25, fontWeight: FontWeight.w300),
                  ),
                  Image(
                    image: AssetImage(picture),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildChannel1() {
    return Container(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ไฟดวงที่ 1",
                style: GoogleFonts.kanit(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              CupertinoSwitch(
                value: switchesD2,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    switchesD2 = value;
                    setState(() {
                      ApiServices().setStatus(
                        widget.deviceName,
                        "D2",
                        switchesD2,
                      );
                    });
                  });
                },
              )
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget buildChannel2() {
    return Container(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ไฟดวงที่ 2",
                style: GoogleFonts.kanit(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              CupertinoSwitch(
                value: switchesD5,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    switchesD5 = value;
                    setState(() {
                      ApiServices().setStatus(
                        widget.deviceName,
                        "D5",
                        switchesD5,
                      );
                    });
                  });
                },
              )
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}

extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
  }
}
