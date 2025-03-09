import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/component/app_bar_udf.dart';
import 'package:emp_management/views/component/location_udf.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer.dart';

class CheckInOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 30.sp,
        children: [
          Text('Hi Kabir Ahmed!',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 28.sp, fontWeight: FontWeight.w400, height: 2.h))),
          StaticDateTime(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/location');
                  },
                  child: buildButton(
                      Icons.thumb_up, 'In', Colors.green, Colors.white)),
              // SizedBox(width: 20.w),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/location');
                },
                child: buildButton(
                    Icons.thumb_down, 'Out', Colors.black54, Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      IconData icon, String text, Color bgColor, Color iconColor) {
    return Container(
      height: 130.h,
      width: 130.w,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10.r)),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 50.sp),
          SizedBox(height: 5.h),
          Text(text,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: whiteColor))),
        ],
      ),
    );
  }
}
