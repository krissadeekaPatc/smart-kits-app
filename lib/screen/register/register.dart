import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/services/api_services.dart';

class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController passCfCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  signUp() {
    _firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailCon.text,
      password: passCon.text,
    )
        .then((result) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      result.user.getIdToken().then((token) {
        ApiServices().createUsers(nameCon.text, "NOT SET", emailCon.text,
            "Male", null, passCon.text, token);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  bool status = false;
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
                flex: 1,
                child: Container(
                  height: _height,
                  width: _width,
                  color: Color(0xff009900),
                ),
              ),
              Expanded(
                flex: 1,
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
                                height: 700,
                                color: Colors.grey[400],
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        "Register",
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
                                                          emailCon.text =
                                                              newValue;
                                                        });
                                                      },
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
                                                          passCon.text =
                                                              newValue;
                                                        });
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
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      onSaved: (newValue) {
                                                        setState(() {
                                                          passCfCon.text =
                                                              newValue;
                                                        });
                                                      },
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Confirm Password",
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
                                                          nameCon.text =
                                                              newValue;
                                                        });
                                                      },
                                                      controller: nameCon,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Display Name",
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
                                              height: 30,
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
                                                            setState(() {
                                                              _formKey
                                                                  .currentState
                                                                  .save();
                                                              setState(() {
                                                                signUp();
                                                              });
                                                            });
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
                                                      child: Text("Register",
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
                                                Text("Already have account?"),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                        "/login",
                                                        (r) => false,
                                                      );
                                                    },
                                                    child: Text(
                                                      "Login here.",
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
}
