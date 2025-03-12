import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/collection_of_attendance.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/admin/employee%20data/employee_statics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controller/emp_Controller.dart';
import '../component/admin_drawer.dart';

class EmployeeListScreen extends StatelessWidget {
  final List<String> employees = [
    "Faius Mojumder Nahin",
    "Md. Sharek",
    "Istiyak Milon",
    "Md. Rakibul Islam",
    "Md. Sorif",
    "Md. Mobusshar Islam",
    "Md. Ratul",
    "Md. Atik",
    "Tazib",
    "Joy Kibria",
    "Rajib Chowdhury",
    "Nazmul Hasan",
    "Saiful Islam",
  ];

  @override
  Widget build(BuildContext context) {
    var emp_provider_true = Provider.of<EmpController>(context, listen: true);
    var emp_provider_false = Provider.of<EmpController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        iconTheme: IconThemeData(color: whiteColor),
        title: Text(
          "Employee List",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ),
        ),
      ),
      drawer: admin_Drawer_Method(context),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("attendance") // Firestore collection name
            .where("date", isEqualTo: DateTime.now().day.toString()) // Filter today's data
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Convert Firestore data into model
            CollectionOfAttendanceDate attendanceData = CollectionOfAttendanceDate.fromFirestore(snapshot.data!);

            return ListView.builder(
              itemCount: attendanceData.collectionOfAttendanceModel.length,
              itemBuilder: (context, index) {
                CollectionOfAttendanceModel emp = attendanceData.collectionOfAttendanceModel[index];

                return ListTile(
                  title: Text(emp.date ?? "Unknown"),
                  subtitle: Text("Check-in: ${emp.checkIn} | Check-out: ${emp.checkOut}"),
                  trailing: Text(emp.attendanceStatus ?? "N/A"),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Icon(Icons.error_outline, color: Colors.red));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      //   body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      // stream: CollectionOfAttendance.collectionAttendance.oneDayDateShow(
      //   date: DateTime.now().day.toString(),
      // ),
      // builder: (BuildContext context, AsyncSnapshot snapshot) {
      //   if (snapshot.hasData) {
      //     List<DocumentSnapshot<Map<String, dynamic>>> data = snapshot.data!.docs;
      //     emp_provider_true.oneDateEmpList = data
      //         .map((e) => CollectionOfAttendanceModel.fromMap(e.data() as Map<String, dynamic>))
      //         .toList();
      //
      //     return Center(child: CircularProgressIndicator(),) ;// Yor UI code
      //   } else if (snapshot.hasError) {
      //   return Icon(Icons.error_outline);
      //   }
      //         return Column(
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.all(10.0.r),
      //               child: RichText(
      //                 text: TextSpan(
      //                   text: 'Total Employees:',
      //                   style: GoogleFonts.roboto(
      //                     textStyle: TextStyle(
      //                       fontSize: 18.sp,
      //                       fontWeight: FontWeight.w400,
      //                       color: Colors.black54,
      //                     ),
      //                   ),
      //                   children: [
      //                     TextSpan(
      //                       text: ' 25  ',
      //                       style: GoogleFonts.roboto(
      //                         textStyle: TextStyle(
      //                           fontSize: 20.sp,
      //                           fontWeight: FontWeight.w400,
      //                           color: Color(0xff73AB6B),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             Divider(color: Colors.black38),
      //             Padding(
      //               padding: EdgeInsets.symmetric(horizontal: 20.w),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     "Name",
      //                     style: GoogleFonts.roboto(
      //                       textStyle: TextStyle(
      //                         fontSize: 18.sp,
      //                         fontWeight: FontWeight.w400,
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.only(right: 30.w),
      //                     child: Text(
      //                       "Preview",
      //                       style: GoogleFonts.roboto(
      //                         textStyle: TextStyle(
      //                           fontSize: 18.sp,
      //                           fontWeight: FontWeight.w400,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Divider(color: Colors.black38),
      //             Expanded(
      //               child: ListView.builder(
      //                 itemCount: emp_provider_true.oneDateEmpList.length,
      //                 itemBuilder: (context, index) {
      //                   return GestureDetector(
      //                     onTap: () {
      //                       Navigator.of(context).push(MaterialPageRoute(
      //                         builder: (context) => EmployeeStatisticsScreen(),
      //                       ));
      //                     },
      //                     child: Padding(
      //                       padding: EdgeInsets.only(left: 10.w, right: 40.w),
      //                       child: ListTile(
      //                         title: Text(
      //                           emp_provider_true.oneDateEmpList[index].toString(),
      //                           style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                               fontSize: 18.sp,
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.w400,
      //                             ),
      //                           ),
      //                         ),
      //                         trailing: Icon(
      //                           Icons.remove_red_eye_outlined,
      //                           color: Color(0xffB1B1B1),
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         );
      //     },
      //   ),
    );
  }
}
