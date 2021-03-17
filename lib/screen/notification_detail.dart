import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsDetailsPage extends StatefulWidget {
  final String title;
  final String headers;
  final String content;
  final String condition;
  final String free;

  const NotificationsDetailsPage(
      {Key key,
      this.title,
      this.headers,
      this.content,
      this.condition,
      this.free})
      : super(key: key);
  @override
  _NotificationsDetailsPageState createState() =>
      _NotificationsDetailsPageState();
}

class _NotificationsDetailsPageState extends State<NotificationsDetailsPage> {
  TextEditingController devicename = TextEditingController();
  String selectProgram = "SELECT PROGRAM";
  List<String> program = [
    "DHT11, LDR and Controller",
    "DHT11, Moisture Sensor and Controller",
    "DHT11 and Controller",
    "LDR and Controller",
    "Moisture Sensor and Controller",
    "Only Input DHT11 & LDR",
    "Only Input DHT11 & Moisture Sensor",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff005C4F),
        title: Text(widget.headers),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 200,
                height: 50,
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Input Device name",
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          devicename.text = value;
                          print(devicename.text);
                        });
                      },
                    ),
                  ),
                  color: Colors.white,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        selectProgram,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  width: 200,
                  height: 50,
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      elevation: 10,
                      builder: (BuildContext builder) {
                        return Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 4,
                          child: CupertinoPicker.builder(
                            useMagnifier: true,
                            childCount: program.length,
                            itemExtent: 70,
                            onSelectedItemChanged: (index) {
                              print(program[index]);
                              setState(() {
                                selectProgram = program[index];
                              });
                            },
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(program[index]),
                              );
                            },
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
