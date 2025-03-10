// SIGN IN / SIGN UP COMPONENT
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commonButton({
  required String name,
  required var color,
  required var txtColor,
  required var boarderColor,
}) {
  return Padding(
    padding: EdgeInsets.only(
      right: 25.w,
      left: 25.w,
    ),
    child: Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: boarderColor),
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(color: txtColor, fontSize: 23.sp)),
        ),
      ),
    ),
  );
}
