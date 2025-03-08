
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildDrawerItem(BuildContext context,String img, String title,Widget page) {
  return ListTile(
    leading: Image.asset(img),
    title: Text(
      title,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(color: Color(0xff414042), fontSize: 20),
      ),
    ),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
    },
  );
}