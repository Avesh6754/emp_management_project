import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/admin/calander/calander.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../controller/emp_Controller.dart';
import '../../../modal/collection_of_attendance.dart';

class EmployeeStatisticsScreen extends StatefulWidget {
  EmployeeStatisticsScreen({super.key, required this.email});

  String email = '';

  @override
  State<EmployeeStatisticsScreen> createState() =>
      _EmployeeStatisticsScreenState();
}

class _EmployeeStatisticsScreenState extends State<EmployeeStatisticsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EmpController>().generateDateRange();
  }

  @override
  Widget build(BuildContext context) {
    var emp_provider_true = Provider.of<EmpController>(context, listen: true);
    var emp_provider_false = Provider.of<EmpController>(context, listen: false);
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
                  "${emp_provider_true.allEmployeeData[emp_provider_true
                      .selectedIndex].email}",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.5.sp,
                        fontSize: 18.sp),
                  ),
                ),
                Text(
                  "${emp_provider_true.allEmployeeData[emp_provider_true
                      .selectedIndex].name}",
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
            )),
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
                    color: Colors.grey.shade800,
                  ),
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
                    value: emp_provider_true.selectedFilter,
                    items: [
                      "Last 7 days",
                      "Last 14 days",
                      "Last 30 days",
                      "This month",
                      "Last month",
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      emp_provider_false.changeSelectedIndex(value);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AttendanceLogScreen(),
                      ));
                    },
                    icon: Icon(Icons.calendar_today),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              FutureBuilder<List<CollectionOfAttendanceModel>>(
                future: emp_provider_false.fetchAllAttendanceRecord(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.hasError.toString()),);
                  }
                  if (snapshot.hasData) {
                    print("record ${snapshot.data!}");
                    List<CollectionOfAttendanceModel> record = snapshot.data!;
                    return (record.isNotEmpty) ? Row(

                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      ...List.generate(record.length, (index) {
                        if(record[index].attendanceTime=='Early' || record[index].attendanceTime=='Late'||record[index].attendanceTime=='OnTime')
                          {
                            return buildCircularIndicator(record[index].attendanceTime!,
                                2, Colors.red);
                          }
                        return Text('No available Data');

                    }
                      ),
                      ],
                    ) : Text('No data Fetch');
                  }
                  return Center(child: CircularProgressIndicator(),);
                },),

              SizedBox(height: 16.h),
              Text(
                "Leave Requests",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                    letterSpacing: 0.5.sp,
                  ),
                ),
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
                // Fetch leave requests dynamically if needed
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h),

              /// Fetch Attendance Data and Display Dynamically
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: CollectionOfAttendance.collectionAttendance
                    .oneDayEmployeeAttendanceData(day: "2025-03-19"),
                // Pass selected date
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No attendance data available",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    );
                  }

                  final attendanceData = snapshot.data!.docs;

                  return Expanded(
                    // Wrap with Expanded to prevent RenderFlex errors
                    child: ListView(
                      children: attendanceData.map((doc) {
                        final data = doc.data();
                        return buildInfoTile(
                            data["status"], "${data["days"]} days");
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          )),
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
