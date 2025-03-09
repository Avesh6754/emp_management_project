import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/admin/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../attendance/attendance_page.dart';
import '../early leavers/eraly_leavers.dart';
import '../employyeList/employee.dart';
import '../late_comes/late_comes.dart';
import 'drawer_option_method.dart';

Drawer admin_Drawer_Method(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          color:greenColor,
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Column(
            children: [
              Container(
                height: 79.h,
                width: 79.w,
                decoration: BoxDecoration(
                  color:  Color(0xff5C8956),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('asset/img/profile.png'),
                  ),
                ),
                child: IconButton(onPressed: () {

                }, icon: Icon(Icons.person_outline_outlined,color: whiteColor,size: 50.sp,)),
              ),
              SizedBox(height: 10.h),
              Text(
                "Hello! MD. Sharafat",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:ListView(
            children: [
              buildDrawerItem(context, 'assets/image/attendance.png', "Attendance", AttendanceScreen()),
              buildDrawerItem(context, 'assets/image/late_comes.png', "Late Comers", LateComersScreen()),
              buildDrawerItem(context, 'assets/image/Book_open.png', "Early Leavers", EarlyLeaversScreen()),
              buildDrawerItem(context, 'assets/image/leaves.png', "Leaves", EarlyLeaversScreen()),//TODO change page
              buildDrawerItem(context, 'assets/image/issue report.png', "DashBoard", HomeScreen()),//TODO change page
              buildDrawerItem(context, 'assets/image/incident.png', "Incident Report", EarlyLeaversScreen()),//TODO change page
              buildDrawerItem(context, 'assets/image/employye.png', "Employee List", EmployeeListScreen()),
              buildDrawerItem(context, 'assets/image/logout.png', "Log out", EarlyLeaversScreen()),//TODO change page
            ],
          ),
        ),
      ],
    ),
  );
}