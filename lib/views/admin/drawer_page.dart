import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/controller/auth_controller.dart';
import 'package:emp_management/modal/attendence_model.dart';
import 'package:emp_management/modal/employee_request.dart';
import 'package:emp_management/services/add_fire_stor_employee_request.dart';
import 'package:emp_management/services/add_fire_store_attendwnce.dart';
import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/views/component/app_bar_udf.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/global.dart';
import 'attendance/attendance_list.dart';
import 'attendance/attendance_page.dart';
import 'component/admin_drawer.dart';
import 'early leavers/eraly_leavers.dart';
import 'employyeList/employee.dart';
import 'late_comes/late_comes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<AuthController>(context, listen: true);
    var providerFalse = Provider.of<AuthController>(context, listen: false);

    DateTime selectedDate = DateTime.now();

    void _selectDate(BuildContext context) async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff73AB6B),
        iconTheme: IconThemeData(color: whiteColor),
        title: Text(
          "Employee Request",
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 25.w, top: 10.h),
            child: Row(
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 50.sp,
                ),
                Text(
                  'Pending ${1}',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black26),
          StreamBuilder(
            stream: AddFireStoreEmployeeRequest.addFireStoreRequest
                .fetchEmployeeRequestData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                    snapshot.data!.docs;
                providerTrue.employeeRequestList = data
                    .map(
                      (e) => EmployeeRequest.fromMap(e.data()),
                    )
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: providerTrue.employeeRequestList.length,
                    itemBuilder: (context, index) {
                      // final emp = providerTrue.employeeRequestList[index];
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(4.0.r),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Employee request'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: TextEditingController(
                                              text: providerTrue
                                                  .employeeRequestList[index]
                                                  .name!),
                                          enabled: false,
                                        ),
                                        TextField(
                                          controller: TextEditingController(
                                              text: providerTrue
                                                  .employeeRequestList[index]
                                                  .email!),
                                          enabled: false,
                                        ),
                                        TextField(
                                          controller: TextEditingController(
                                              text: providerTrue
                                                  .employeeRequestList[index]
                                                  .status!),
                                          enabled: false,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await AuthServices.authServices
                                              .createAccount(
                                            email: providerTrue
                                                .employeeRequestList[index]
                                                .email!,
                                            password: providerTrue
                                                .employeeRequestList[index]
                                                .password!,
                                          );

                                          await AddFireStoreEmployeeRequest
                                              .addFireStoreRequest
                                              .update(
                                            email: providerTrue
                                                .employeeRequestList[index]
                                                .email!,
                                          );

                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Approve',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await AddFireStoreEmployeeRequest
                                              .addFireStoreRequest
                                              .deleteData(
                                            email: providerTrue
                                                .employeeRequestList[index]
                                                .email!,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Reject',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Text(
                                providerTrue.employeeRequestList[index].name!,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                providerTrue.employeeRequestList[index].email!,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        providerTrue
                                            .employeeRequestList[index].status!,
                                        style: GoogleFonts.roboto(
                                          color: providerTrue
                                                      .employeeRequestList[
                                                          index]
                                                      .status ==
                                                  "Approved"
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
