import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticDateTime extends StatelessWidget {
  const StaticDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text('09:55 AM',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ))),
        Text('Wednesday, Feb 17',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.w400))),
        SizedBox(height: 20),
      ],
    );
  }
}
