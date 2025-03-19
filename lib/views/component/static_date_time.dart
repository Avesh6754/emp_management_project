import 'dart:developer';

import 'package:emp_management/controller/time_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StaticDateTime extends StatelessWidget {
  const StaticDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    var dateproviderT=Provider.of<DateTimeProvider>(context,listen: true);
    var dateproviderF=Provider.of<DateTimeProvider>(context,listen: false);
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text('${dateproviderT.formattedTime}',
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                ))),
        // Text('Wednesday, Feb 17',
        //     style: GoogleFonts.roboto(
        //         textStyle: TextStyle(
        //             fontSize: 30.sp,fontWeight: FontWeight.w400))),
        SizedBox(height: 20.h),

      ],
    );
  }
}
