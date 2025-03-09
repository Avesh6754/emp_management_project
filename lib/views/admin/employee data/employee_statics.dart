import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EmployeeStatisticsScreen extends StatelessWidget {
  const EmployeeStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: Column(
            spacing: 5.h,
            children: [
              Container(
                height: 75.h,
                width: 75.w,
                decoration: BoxDecoration(
                  color: Color(0xff5C8956),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  size: 40.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                "Employee ID : 123456",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5.sp,
                      fontSize: 18.sp),
                ),
              ),
              Text(
                "Faius Mojumder Nahin",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5.sp,
                  fontSize: 20.sp,
                )),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Statistics",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 20.sp,
                    letterSpacing: 0.5.sp,
                    color: Colors.grey.shade800),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                  value: "Last 14 days",
                  items: [
                    "Last 7 days",
                    "Last 14 days",
                    "Last 30 days",
                    "This months",
                    "Last months",
                  ]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                ),
                IconButton(
                  ///todo : logic :-)
                  onPressed: () {
                    Navigator.of(context).pushNamed('/calander');
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCircularIndicator("Late", 0.1, Colors.red),
                buildCircularIndicator("Absent", 0.05, Colors.orange),
                buildCircularIndicator("Leaves", 0.05, Colors.green),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "Leave Requests",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                      letterSpacing: 0.5.sp)),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30.sp,
              ),
              decoration: InputDecoration(border: OutlineInputBorder()),
              hint: Text(
                "Tap to view leave requests",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp,
                      letterSpacing: 0.5.sp),
                ),
              ),
              items: [],
              onChanged: (value) {},
            ),
            SizedBox(height: 16.h),
            buildInfoTile("Total Presents", "12 days"),
            buildInfoTile("Late", "2 days"),
            buildInfoTile("Early Leaves", "2 days"),
            buildInfoTile("Absent", "1 day"),
            buildInfoTile("Leaves", "1 day"),
          ],
        ),
      ),
    );
  }

  Widget buildCircularIndicator(String label, double percent, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0.r,
          lineWidth: 8.0.w,
          backgroundColor: Colors.grey.shade300,
          percent: percent,
          center: Text(
            "${(percent * 100).toInt()}%",
            style: GoogleFonts.roboto(
                textStyle:
                    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
          ),
          progressColor: color,
        ),
        SizedBox(height: 10.h),
        Text(
          label,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600)),
        ),
      ],
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                    letterSpacing: 0.5.sp)),
          ),
          Container(
            alignment: Alignment.center,
            width: 100.w,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade600)),
            child: Text(
              value,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      letterSpacing: 0.2.sp)),

            ),
          ),
        ],
      ),
    );
  }
}
