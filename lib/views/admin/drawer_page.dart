import 'package:emp_management/views/component/app_bar_udf.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'attendance/attendance_page.dart';
import 'component/admin_drawer.dart';
import 'early leavers/eraly_leavers.dart';
import 'employyeList/employee.dart';
import 'late_comes/late_comes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      drawer: admin_Drawer_Method(context),
      body: Center(child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 30.sp, fontWeight: FontWeight.w400))),
          SizedBox(height: 20.h),
        ],
      ),)
    );
  }
}
