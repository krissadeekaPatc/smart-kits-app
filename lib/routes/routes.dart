import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/home.dart';
import 'package:smartfarm/screen/chart.dart';
import 'package:smartfarm/screen/controller.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:smartfarm/screen/login.dart';
import 'package:smartfarm/screen/manual_page.dart';
import 'package:smartfarm/screen/porfiles.dart';
import 'package:smartfarm/screen/register/register.dart';
import 'package:smartfarm/screen/weekly_chart.dart';
import 'package:smartfarm/screen/widget/example.dart';

enum ROUTE_NAME {
  home,
  register,
  login,
  profiles,
  controller,
  manual,
}

class AppRoutes extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String initPage() {
    try {
      if (_auth.currentUser.uid != null) {
        return "/home";
      } else {}
      return "/login";
    } catch (e) {
      return "/login";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => Homepage(),
        '/register': (context) => Registerpage(),
        '/profiles': (context) => Profiles(),
        '/controller': (context) => ControllerPage(),
        '/chart': (context) => WeeklyChart(),
        '/manual': (context) => ManualPage(),
      },
      theme: ThemeData(
        backgroundColor: Colors.black,
        cardColor: Colors.transparent,
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        brightness: Brightness.light,
      ),
    );
  }
}
