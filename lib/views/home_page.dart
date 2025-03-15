// import 'package:emp_management/controller/auth_controller.dart';
// import 'package:emp_management/controller/emp_Controller.dart';
// import 'package:emp_management/modal/attendence_model.dart';
// import 'package:emp_management/services/add_fire_store_attendwnce.dart';
// import 'package:emp_management/utils/global.dart';
// import 'package:emp_management/views/component/app_bar_udf.dart';
// import 'package:emp_management/views/component/location_udf.dart';
// import 'package:emp_management/views/component/static_date_time.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// import 'drawer.dart';
//
// class CheckInOutScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var emp_roviderTrue = Provider.of<EmpController>(context, listen: true);
//     var emp_roviderfalse = Provider.of<EmpController>(context, listen: false);
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         spacing: 30.sp,
//         children: [
//           Text(
//             "Hi, ${emp_roviderTrue.user!.email}",
//             style: GoogleFonts.roboto(
//               textStyle: TextStyle(
//                 fontSize: 28.sp,
//                 fontWeight: FontWeight.w400,
//                 height: 2.h,
//               ),
//             ),
//           ),
//           StaticDateTime(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CupertinoButton(
//                   onPressed: () async {
//                     await emp_roviderfalse.getCurrentLocation();
//
//                     AddFireStoreAttendance.addAttendance.updateAttendance(
//                       email: emp_roviderTrue.user!.email!,
//                       address: emp_roviderTrue.empAddress!,
//                       checkIn: DateTime.now().toString(),
//                       checkOut: "",
//                       lat: emp_roviderTrue.empLatitude,
//                       long: emp_roviderTrue.empLongitude,
//                       status: "present",
//                     );
//
//                     Navigator.of(context).pushNamed('/location');
//                   },
//                   child: buildButton(
//                       Icons.thumb_up, 'In', Colors.green, Colors.white)),
//               // SizedBox(width: 20.w),
//               CupertinoButton(
//                 onPressed: () {
//                   AddFireStoreAttendance.addAttendance.updateAttendance(
//                     email: emp_roviderTrue.user!.email!,
//                     address: emp_roviderTrue.empAddress!,
//                     checkIn: "",
//                     checkOut: DateTime.now().toString(),
//                     lat: emp_roviderTrue.empLatitude,
//                     long: emp_roviderTrue.empLongitude,
//                     status: "present",
//                   );
//
//                   Navigator.of(context).pushReplacementNamed('/location');
//                 },
//                 child: buildButton(
//                     Icons.thumb_down, 'Out', Colors.black54, Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildButton(
//       IconData icon, String text, Color bgColor, Color iconColor) {
//     return Container(
//       height: 130.h,
//       width: 130.w,
//       decoration: BoxDecoration(
//           color: bgColor, borderRadius: BorderRadius.circular(10.r)),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: iconColor, size: 50.sp),
//           SizedBox(height: 5.h),
//           Text(
//             text,
//             style: GoogleFonts.roboto(
//               textStyle: TextStyle(
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.w700,
//                 color: whiteColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }\
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
    var dateproviderT=Provider.of<DateTimeProvider>(context,listen: true);
    var dateproviderF=Provider.of<DateTimeProvider>(context,listen: false);
    // empProvider.resetCheckInIfNewDay(); // Ensure daily reset

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
                  dateproviderF.checkTimeOut();
                  empProvider.setCheckInStatus(true);
                  CollectionOfAttendanceModel employee =
                  CollectionOfAttendanceModel(
                    isCheckIn:empProvider.isCheckedIn,
                    isCheckOut: !empProvider.isCheckedOut,
                    email: empProvider.user!.email!,
                    checkIn:((empProvider.empAddress !=
                        "police station, Surat, Gujarat, India"))? "":((empProvider.empAddress !=
                        "Uma plaza Star Circle, Surat, Gujarat, India"))
                        ?dateproviderT.onlyTime:"" ,
                    checkOut: "",
                    date: DateTime.now().day.toString(),
                    attendanceTime: "",
                    reason: "",
                    attendanceStatus:  ((empProvider.empAddress !=
                        "police station, Surat, Gujarat, India"))? "Absent":((empProvider.empAddress !=
                        "Uma plaza Star Circle, Surat, Gujarat, India"))?"Present":"Absent",
                  );

                  await CollectionOfAttendance.collectionAttendance
                      .addCollectionEmployee(
                    employee,
                    DateTime.now().day.toString(),
                  );

                  empProvider.setCheckInStatus(true);
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
                onPressed: !empProvider.isCheckedIn
                    ? null
                    : () async {

                  CollectionOfAttendanceModel employee =
                  CollectionOfAttendanceModel(
                    isCheckOut: empProvider.isCheckedOut,
                    isCheckIn:empProvider.isCheckedIn,
                    email: empProvider.user!.email!,
                    checkOut:((empProvider.empAddress !=
                        "police station, Surat, Gujarat, India"))? "":((empProvider.empAddress !=
                        "Uma plaza Star Circle, Surat, Gujarat, India"))
                        ?dateproviderT.onlyTime:"" ,
                    checkIn: "",
                    date: DateTime.now().day.toString(),
                    attendanceTime: "",
                    reason: "",
                    attendanceStatus: ((empProvider.empAddress !=
                        "police station, Surat, Gujarat, India"))? "Absent":((empProvider.empAddress !=
                        "Uma plaza Star Circle, Surat, Gujarat, India"))?"Present":"Absent",
                  );

                  await CollectionOfAttendance.collectionAttendance
                      .updateCollectionEmployee(
                    employee,
                    DateTime.now().day.toString(),
                  );


                  Navigator.of(context).pushReplacementNamed('/location');
                },
                child: buildButton(
                  Icons.thumb_down,
                  'Check Out',
                  !empProvider.isCheckedIn ? Colors.grey : Colors.black54,
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

