import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfarm/controller/textcontroller.dart';
import 'package:smartfarm/services/api_services.dart';

class ControllerWidget extends StatefulWidget {
  bool status;
  final String channel;
  final String devicename;
  final String uid;
  final String channelName;
  final Function onChange;

  ControllerWidget({
    Key key,
    this.status,
    this.channel,
    this.devicename,
    this.uid,
    this.channelName,
    this.onChange,
  }) : super(key: key);
  @override
  _ControllerWidgetState createState() => _ControllerWidgetState();
}

class _ControllerWidgetState extends State<ControllerWidget> {
  @override
  Widget build(BuildContext context) {
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
                widget.channelName,
                style: GoogleFonts.kanit(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CupertinoSwitch(
                value: widget.status,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    widget.status = value;
                    setState(() {
                      ApiServices().setStatus(
                        widget.devicename,
                        widget.channel,
                        widget.status,
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

extension BoolParsings on String {
  bool parseBools() {
    return this.toLowerCase() == 'true';
  }
}
