import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/screen/widget/primary_button.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextController con = TextController();
  signOut() {
    try {
      _auth.signOut().then((value) {
        con.uid.text = null;
        con.emailController.text = null;
        con.userNamecontroller.text = null;
        con.lastNameController.text = null;

        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff005C4F),
                            Color(0xff70B16D),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.white,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Image(
                              image:
                                  Image.asset("assets/logo/support.png").image),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        con.userNamecontroller.text,
                        style: GoogleFonts.kanit(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        con.emailController.text,
                        style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 60, left: 20),
                        child: Text(
                          "Account Info",
                          style: GoogleFonts.kanit(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 100,
                        ),
                        child: Column(
                          children: [
                            buildInfo("Name", con.userNamecontroller.text,
                                "assets/logo/support.png"),
                            buildInfo("Mobile Phone", con.phoneController.text,
                                "assets/logo/mobile.png"),
                            buildInfo("Email", con.emailController.text,
                                "assets/logo/message.png"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryButton(
                                onPressed: () {
                                  signOut();
                                },
                                child: Text(
                                  "Log Out",
                                  style: GoogleFonts.kanit(
                                      color: Colors.white, fontSize: 20),
                                ),
                                height: 50,
                                width: 300,
                                radius: 30,
                                // border: Border.all(),
                                gradient: LinearGradient(colors: [
                                  Color(0xff005C4F),
                                  Color(0xff005C4F),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String headers, String body, String image) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.transparent,
            child: Image.asset(image),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headers,
                style: GoogleFonts.kanit(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(body),
            ],
          )
        ],
      ),
    );
  }
}
