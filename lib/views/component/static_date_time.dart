import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StaticDateTime extends StatelessWidget {
  const StaticDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text('09:55 AM',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w700,
                ))),
        Text('Wednesday, Feb 17',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 30.sp,fontWeight: FontWeight.w400))),
        SizedBox(height: 20.h),
      ],
    );
  }
}
