// for TEXTFEILD COMPONENT
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/global.dart';

Padding authtxtContainer({required String hint , required IconData icon, required bool isIcon}) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, left: 28, right: 28),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon:(isIcon)?Icon(icon,color: greyColor,size: 30,):null,
        hintStyle: TextStyle(color: greyColor,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greyColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}