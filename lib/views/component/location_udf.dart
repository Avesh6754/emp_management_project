import 'package:emp_management/views/component/app_bar_udf.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drawer_udf.dart';

class OfficeLocationScreen extends StatelessWidget {
  const OfficeLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      drawer: SideMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StaticDateTime(),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.amber),
                SizedBox(width: 8.w),
                Text(
                  "Status: ",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                ),
                Text(
                  "You are not in office range",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(fontSize: 16.sp, color: Colors.red)),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[300],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you want to change your location?",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/check');
                        },
                        child: const Text("Yes"),
                      ),
                      SizedBox(width: 10.w),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                        ),
                        onPressed: () {},
                        child: const Text("No"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Your Location: Block C, 24/A Tajmahal Road (Ring Road, Near Shia Mosque, Dhaka 1207",
                    style: GoogleFonts.roboto(
                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Note: Please go inside Office range then ",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 16.sp),
              ),
            ),
            Text(
              "try again!",
              style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),

            ),
          ],
        ),
      ),
    );
  }
}
