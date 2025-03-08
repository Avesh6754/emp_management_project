// SIGN IN / SIGN UP COMPONENT
import 'package:flutter/cupertino.dart';

Widget commonButton(
    {required String name,
      required var color,
      required var txtColor,
      required var boarderColor}) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 25,
      left: 25,
    ),
    child: Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: boarderColor),
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: txtColor,
              fontSize: 23,
            ),
          )),
    ),
  );
}