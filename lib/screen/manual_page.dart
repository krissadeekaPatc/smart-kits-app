import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManualPage extends StatefulWidget {
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manual Page",
          style: GoogleFonts.kanit(),
        ),
        backgroundColor: Color(0xff005C4F),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            buildCard(context, "User Manual"),
            buildCard(context, "Contact us"),
          ],
        ),
      ),
    );
  }

  Container buildCard(BuildContext context, String text) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).copyWith().size.width,
      child: Card(
        elevation: 20,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 30),
          ),
        ),
        color: Color(0xff005C4F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
