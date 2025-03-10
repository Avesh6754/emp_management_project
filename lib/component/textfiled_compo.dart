// for TEXTFEILD COMPONENT
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/global.dart';

Padding authtxtContainer(
    {required String hint, required IconData icon, required bool isIcon}) {
  return Padding(
    padding: EdgeInsets.only(top: 30.h, left: 28.w, right: 28.w),
    child: TextField(
      // controller: ,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: (isIcon)
            ? Icon(
                icon,
                color: greyColor,
                size: 30.sp,
              )
            : null,
        hintStyle: GoogleFonts.roboto(textStyle: TextStyle(color: greyColor)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: greyColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    ),
  );
}
