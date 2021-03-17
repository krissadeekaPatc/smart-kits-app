import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/models/inputValue_models.dart';
import 'package:smartfarm/models/sensor_model.dart';
import 'package:smartfarm/screen/controller.dart';
import 'package:smartfarm/screen/notifications.dart';
import 'package:smartfarm/services/api_services.dart';
import 'package:smartfarm/services/push_notification.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<SensorModels> sensorValue = List<SensorModels>();
  List<InputValueModels> inputValue = List<InputValueModels>();

  String dateName = DateFormat('EEEE').format(DateTime.now());
  String date = DateFormat('d').format(DateTime.now());
  String month = DateFormat('MMMM').format(DateTime.now());
  String year = DateFormat('y').format(DateTime.now());
  List picture = [
    "assets/picture/cloud.png",
    "assets/picture/cloud.png",
  ];
  bool isLoading = true;
  String uid;
  Timer a;
  TextController con = TextController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void initFirebaseMessaging() {
    firebaseMessaging.configure(
      onMessage: (message) async {
        print(message);
        if (Platform.isIOS) {
          print("IOS ${message}");
          buildNoti(message["aps"]["alert"]["title"],
              message["aps"]["alert"]["body"]);
        }

        buildNoti(
            message["notification"]["title"], message["notification"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationList(),
            ));
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationList(),
            ));
      },
    );

    firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));

    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Token : $token");
    });
  }

  OverlaySupportEntry buildNoti(String title, String body) {
    return showSimpleNotification(
      InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationList(),
            )),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.itim(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    body,
                    style: GoogleFonts.itim(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      background: Colors.white,
      elevation: 20,
      slideDismiss: true,
      // trailing: Text(
      //   message["notification"]["title"],
      //   style: GoogleFonts.itim(color: Colors.black),
      // ),
      // subtitle: Text(
      //   message["notification"]["body"],
      //   style: GoogleFonts.itim(
      //     color: Colors.black,
      //     fontSize: 20,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    a.cancel();
    super.dispose();
  }

  @override
  void initState() {
    initFirebaseMessaging();
    setState(() {
      uid = FirebaseAuth.instance.currentUser.uid;

      _auth.currentUser.getIdToken().then((value) => print(value));
      print(_auth.currentUser.uid);
      setState(() {
        fetchUsers();
        setState(() {
          getOnce();
        });
      });
    });

    super.initState();
    a = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        getOnce();
      });
    });
  }

  getOnce() {
    ApiServices().getAllSensor().then((value) {
      setState(() {
        sensorValue.clear();
        sensorValue.addAll(value);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  fetchUsers() {
    setState(() {
      ApiServices().getUsersModel().then((value) {
        setState(() {
          con.emailController.text = usersModelSingleton[0].email;
          con.userNamecontroller.text = usersModelSingleton[0].username;
          con.phoneController.text = usersModelSingleton[0].phone;
          con.emailController.text = usersModelSingleton[0].email;
          con.uid.text = _auth.currentUser.uid;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            Container(
              width: _width,
              height: _height,
              color: Color(0xff005C4F),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationList(),
                        ),
                      );
                    },
                    child: Image(
                      image: AssetImage("assets/picture/bell.png"),
                      width: 60,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: isLoading
                      ? TextController().spinkit
                      : PageView.builder(
                          controller: PageController(
                            viewportFraction: 0.95,
                            initialPage: 0,
                            keepPage: true,
                          ),
                          itemCount:
                              sensorValue.isEmpty ? 0 : sensorValue.length,
                          pageSnapping: true,
                          itemBuilder: (context, index) {
                            return sensorValue[index]
                                        .inputValue[sensorValue[index]
                                                .inputValue
                                                .length -
                                            1]
                                        .temperature ==
                                    null
                                ? Container(
                                    child: Card(
                                        elevation: 30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                                "There isn't has any device"))))
                                : buildCard(context, index);
                          }),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    child: Container(
                      width: _width,
                      color: Color(0xffF4F2F2),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 15),
                              child: Text(
                                "What do you need ?",
                                style: GoogleFonts.kanit(fontSize: 20),
                              ),
                            ),
                            squareGird(
                                "/profiles",
                                "assets/picture/profiles.png",
                                "Profiles",
                                context,
                                10,
                                35),
                            squareGird("/chart", "assets/picture/garph.png",
                                "Graph Average Week", context, 10, 10),
                            squareGird("/manual", "assets/picture/manul.png",
                                "Manual", context, 10, 35),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ControllerPage(
                deviceName: sensorValue[index].devicename,
                switchesD5: sensorValue[index].d5,
                switchesD2: sensorValue[index].d2,
                switchesD1: sensorValue[index].d1,
                switchesD6: sensorValue[index].d6,
                automation: sensorValue[index].automation,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
          ),
          color: Colors.white,
          child: Center(
              child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xffFFDFC9),
                    Color(0xffFCF5C7),
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, top: 40),
                  child: Image(
                    image: AssetImage("assets/picture/clouds.png"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Humidity",
                    style: GoogleFonts.kanit(
                        color: Colors.grey[600], fontSize: 35),
                  ),
                ),
                SizedBox(
                  width: 31,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0, right: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  sensorValue.isEmpty
                      ? SizedBox()
                      : Text(
                          "${double.parse(sensorValue[index].inputValue[sensorValue[index].inputValue.length - 1].humidity).toStringAsFixed(0)}%",
                          style: GoogleFonts.kanit(
                            fontSize: 90,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(5.0, 9.0),
                                blurRadius: 10.0,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("assets/picture/suns.png"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0, left: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Light",
                      style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            offset: Offset(5.0, 9.0),
                            blurRadius: 10.0,
                            color: Colors.grey[700],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 31,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 80.0, left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sensorValue.isEmpty
                      ? SizedBox()
                      : Text(
                          "${double.parse(sensorValue[index].inputValue[sensorValue[index].inputValue.length - 1].light).toStringAsFixed(0)}",
                          style: GoogleFonts.kanit(
                            fontSize: 50,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(5.0, 9.0),
                                blurRadius: 10.0,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 90.0, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      sensorValue.isEmpty
                          ? SizedBox()
                          : Text(
                              "${sensorValue[index].inputValue[sensorValue[index].inputValue.length - 1].temperature}°C",
                              style: GoogleFonts.kanit(
                                fontSize: 70,
                                color: Color(0xff8B8B8B),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40, left: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            dateName,
                            style: GoogleFonts.kanit(
                              fontSize: 30,
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            date,
                            style: GoogleFonts.kanit(
                              fontSize: 25,
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            month,
                            style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Color(0xff8B8B8B),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            year,
                            style: GoogleFonts.kanit(
                              fontSize: 20,
                              color: Color(0xff8B8B8B),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ])),
        ),
      ),
    );
  }

  Widget squareGird(String routeName, String picture, String menu,
      BuildContext context, double left, double right) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, routeName);
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
}
