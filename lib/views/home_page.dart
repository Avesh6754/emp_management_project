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

import 'drawer.dart';

class CheckInOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var empProvider = Provider.of<EmpController>(context);
    bool isCheckedIn = empProvider.isCheckedIn;

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
                onPressed: isCheckedIn
                    ? null
                    : () async {
                        await empProvider.getCurrentLocation();
                        CollectionOfAttendanceModel employee =
                            CollectionOfAttendanceModel(
                          email: empProvider.user!.email!,
                          checkOut: "",
                          checkIn: DateTime.now().toString(),
                          date: DateTime.now().day.toString(),
                          attendanceTime: "",
                          reason: "",
                          attendanceStatus: "",
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
                  isCheckedIn ? Colors.grey : Colors.green,
                  Colors.white,
                ),
              ),
              CupertinoButton(
                onPressed: !isCheckedIn
                    ? null
                    : () async {
                        CollectionOfAttendanceModel employee =
                            CollectionOfAttendanceModel(
                          email: empProvider.user!.email!,
                          checkOut: DateTime.now().toString(),
                          checkIn: "",
                          date: DateTime.now().day.toString(),
                          attendanceTime: "",
                          reason: "",
                          attendanceStatus: "",
                        );
                        await CollectionOfAttendance.collectionAttendance
                            .updateCollectionEmployee(
                          employee,
                          DateTime.now().day.toString(),
                        );

                        empProvider.setCheckInStatus(false);
                        Navigator.of(context).pushReplacementNamed('/location');
                      },
                child: buildButton(
                  Icons.thumb_down,
                  'Check Out',
                  !isCheckedIn ? Colors.grey : Colors.black54,
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
