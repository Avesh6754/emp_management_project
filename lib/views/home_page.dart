import 'dart:developer';

import 'package:emp_management/controller/emp_Controller.dart';
import 'package:emp_management/modal/collection_of_attendance.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/time_controller.dart';
import 'drawer.dart';

class CheckInOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var empProvider = Provider.of<EmpController>(context);
    var dateproviderT = Provider.of<DateTimeProvider>(context, listen: true);
    var dateproviderF = Provider.of<DateTimeProvider>(context, listen: false);
    // empProvider.resetCheckInIfNewDay(); //
    // Ensure daily reset
    DateTime now = DateTime.now();
    int currentDay = now.day;

    // Check if Check-In was done yesterday
    bool isNextDayCheckOut = empProvider.lastCheckInDate != null &&
        empProvider.lastCheckInDate != currentDay;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Text(
            "Hi, ${empProvider.user?.email ?? ''}",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w400,
                height: 2.h,
              ),
            ),
          ),
          StaticDateTime(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: empProvider.isCheckedIn
                    ? null
                    : () async {
                        await empProvider.getCurrentLocation();

                        log("time================================${dateproviderT.onlyTime}");
                        dateproviderF.checkTimeIn();
                        empProvider.setCheckInStatus(true, currentDay);
                        CollectionOfAttendanceModel employee =
                            CollectionOfAttendanceModel(
                          attendenceCheckouTime: "",
                          isCheckIn: empProvider.isCheckedIn,
                          isCheckOut: empProvider.isCheckedOut,
                          email: empProvider.user!.email!,
                          checkIn: ((empProvider.empAddress !=
                                  "police station, Surat, Gujarat, India"))
                              ? ""
                              : ((empProvider.empAddress !=
                                      "Uma plaza Star Circle, Karadva, Gujarat, India"))
                                  ? dateproviderT.onlyTime
                                  : "",
                          checkOut: "",
                          date: currentDay.toString(),
                          attendanceTime: dateproviderF.checkTimeIn(),
                          reason: "",
                          attendanceStatus: ((empProvider.empAddress !=
                                  "police station, Surat, Gujarat, India"))
                              ? "Absent"
                              : ((empProvider.empAddress !=
                                      "Uma plaza Star Circle, Karadva, Gujarat, India"))
                                  ? "Present"
                                  : "Absent",
                        );
                        if (empProvider.empAddress ==
                                "police station, Surat, Gujarat, India" ||
                            empProvider.empAddress ==
                                "Uma plaza Star Circle, Karadva, Gujarat, India") {
                          empProvider.updateCheckIn(dateproviderT.onlyTime!);
                        }

                        await CollectionOfAttendance.collectionAttendance
                            .addCollectionEmployee(
                          employee,
                          currentDay.toString(),
                        );

                        empProvider.setCheckInStatus(true, currentDay);
                        Navigator.of(context).pushNamed('/location');
                      },
                child: buildButton(
                  Icons.thumb_up,
                  'Check In',
                  empProvider.isCheckedIn ? Colors.grey : Colors.green,
                  Colors.white,
                ),
              ),
              CupertinoButton(
                onPressed: (empProvider.isCheckedOut || isNextDayCheckOut)
                    ? null
                    : () async {
                        dateproviderF.checkTimeOut();
                        empProvider.setCheckOutStatus(true);

                        CollectionOfAttendanceModel employee =
                            CollectionOfAttendanceModel(
                          attendenceCheckouTime: dateproviderF.checkTimeOut(),
                          isCheckOut: empProvider.isCheckedOut,
                          isCheckIn: empProvider.isCheckedIn,
                          email: empProvider.user!.email!,
                          checkOut: ((empProvider.empAddress !=
                                  "police station, Surat, Gujarat, India"))
                              ? ""
                              : ((empProvider.empAddress !=
                                      "Uma plaza Star Circle, Karadva, Gujarat, India"))
                                  ? dateproviderT.onlyTime
                                  : "",
                          checkIn: "",
                          date: DateTime.now().day.toString(),
                          attendanceTime: '',
                          reason: "",
                          attendanceStatus: ((empProvider.empAddress !=
                                  "police station, Surat, Gujarat, India"))
                              ? "Absent"
                              : ((empProvider.empAddress !=
                                      "Uma plaza Star Circle, Karadva, Gujarat, India"))
                                  ? "Present"
                                  : "Absent",
                        );
                        if (empProvider.empAddress ==
                                "police station, Surat, Gujarat, India" ||
                            empProvider.empAddress ==
                                "Uma plaza Star Circle, Karadva, Gujarat, India") {
                          empProvider.updateCheckOut(dateproviderT.onlyTime!);
                        }
                        await CollectionOfAttendance.collectionAttendance
                            .updateCollectionEmployee(
                                employee,
                                currentDay.toString(),
                                dateproviderF.checkTimeOut());

                        Navigator.of(context).pushNamed('/location');
                      },
                child: buildButton(
                  Icons.thumb_down,
                  'Check Out',
                  (!empProvider.isCheckedIn || !isNextDayCheckOut)
                      ? Colors.grey
                      : Colors.black54,
                  Colors.white,
                ),
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
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 50.sp),
          SizedBox(height: 5.h),
          Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
