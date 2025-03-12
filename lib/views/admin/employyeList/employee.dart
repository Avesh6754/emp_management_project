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
import '../../../modal/employee_request.dart';
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
      body: StreamBuilder(
        stream: CollectionOfAttendance.collectionAttendance.allEmployeeData(
            date:
                "${DateTime.now().day} : ${DateTime.now().month} : ${DateTime.now().year}"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                snapshot.data!.docs;
            emp_provider_true.allEmployeeData = data
                .map(
                  (e) => AddDetails.fromMap(e.data()),
                )
                .toList();

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: RichText(
                    text: TextSpan(
                      text: 'Total Employees:',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: ' ${emp_provider_true.allEmployeeData.length}  ',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff73AB6B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.black38),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w),
                        child: Text(
                          "Preview",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black38),
                Expanded(
                  child: ListView.builder(
                    itemCount: emp_provider_true.allEmployeeData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmployeeStatisticsScreen(),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 40.w),
                          child: ListTile(
                            title: Text(
                              emp_provider_true.allEmployeeData[index].name,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            trailing: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Color(0xffB1B1B1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
