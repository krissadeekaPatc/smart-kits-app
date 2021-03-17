import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/screen/register/register.dart';
import 'package:smartfarm/services/authenticationservices.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool status = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  height: _height,
                  width: _width,
                  color: Color(0xff009900),
                ),
              ),
              Expanded(
                child: Container(
                  height: _height,
                  width: _width,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Container(
                    width: _width,
                    color: Color(0xff009900),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset("assets/logo/logo.png"),
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20),
                                width: _width,
                                height: 660,
                                color: Colors.grey[400],
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        "Login to your account",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(60),
                                        topRight: Radius.circular(60),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      child: Container(
                                        width: _width,
                                        height: _height * 0.65, // 583,
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    "assets/logo/fb.png"),
                                                SizedBox(
                                                  width: 60,
                                                ),
                                                Image.asset(
                                                    "assets/logo/gg.png"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Or use your email account",
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Form(
                                              key: _formKey,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40.0,
                                                    right: 40,
                                                    top: 20),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      onSaved: (newValue) {
                                                        setState(() {
                                                          emailController.text =
                                                              newValue;
                                                        });
                                                      },
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      validator: (value) => value
                                                              .isEmpty
                                                          ? "Please enter email."
                                                          : !value.contains(
                                                                      "@") ||
                                                                  !value
                                                                      .contains(
                                                                          ".")
                                                              ? "Invalid Email form"
                                                              : null,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Email",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green)),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.green,
                                                              style: BorderStyle
                                                                  .solid),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      onSaved: (newValue) {
                                                        setState(() {
                                                          password.text =
                                                              newValue;
                                                        });
                                                      },
                                                      validator: (value) {
                                                        return value.isEmpty
                                                            ? "Please enter password."
                                                            : value.length < 8
                                                                ? "Please enter pasword more than 8 charactors."
                                                                : null;
                                                      },
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Password",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green)),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.green,
                                                              style: BorderStyle
                                                                  .solid),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Checkbox(
                                                  activeColor:
                                                      Color(0xff009900),
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      status = value;
                                                    });
                                                  },
                                                  value: status,
                                                ),
                                                Text(
                                                  "Remember me",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      left: 45,
                                                      right: 45,
                                                    ),
                                                    height: 50,
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _formKey.currentState
                                                              .validate();
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            _formKey
                                                                .currentState
                                                                .save();
                                                            signIn(context);
                                                          }
                                                        });
                                                      },
                                                      animationDuration:
                                                          Duration(seconds: 1),
                                                      color: Color(0xff009900),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      child: Text("Login",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Don't have account?"),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                        "/register",
                                                        ModalRoute.withName(
                                                            '/login'),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Register here.",
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xff009900,
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signIn(BuildContext context) {
    return setState(() {
      firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: password.text)
          .then((result) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      }).catchError((error) {
        print(error);
      });
    });
  }
}
