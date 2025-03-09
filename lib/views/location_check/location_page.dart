import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../component/app_bar_udf.dart';
import '../component/drawer_udf.dart';
import '../component/static_date_time.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      drawer: SideMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  StaticDateTime(),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 28.sp,
                ),
                SizedBox(width: 8.w),
                AutoSizeText(
                  'Status:',
                  minFontSize: 18,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800)),
                ),
                AutoSizeText(
                  ' Now you are at NBR', minFontSize: 18,
                  maxLines: 2,
                  style:
                      GoogleFonts.roboto(textStyle: TextStyle(fontSize: 20.sp)),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(23.7337, 90.3938),
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(23.7337, 90.3938),
                  ),
                },
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.grey,
                  size: 30.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Your Location:',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23.sp,
                              ),
                            )),
                        TextSpan(
                          text: 'Find your location in app:',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(

                              fontSize: 23.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("You are late!!!",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        )),
                                    SizedBox(height: 10.h),
                                    Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                      size: 40.sp,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text("Select a reason"),
                                    RadioListTile(
                                      title: Text("Traffic Jam"),
                                      value: "Traffic Jam",
                                      groupValue: selectedReason,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedReason = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text("Health Issue"),
                                      value: "Health Issue",
                                      groupValue: selectedReason,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedReason = value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text("Others"),
                                      value: "Others",
                                      groupValue: selectedReason,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedReason = value.toString();
                                        });
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {},
                                      child: Text("Submit"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Save')),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.green,
                      size: 50.sp,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '09:55',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('Check In',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey, fontSize: 20.sp))),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 50.sp,
                    ),
                    SizedBox(height: 5.h),
                    Text('--:--',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold))),
                    Text('Check Out',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey, fontSize: 20.sp))),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50.sp,
                    ),
                    SizedBox(height: 5.h),
                    Text('--:--',
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        )),
                    Text(
                      "Working Hr's",
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.grey, fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h
            ),
          ],
        ),
      ),
    );
  }
}
