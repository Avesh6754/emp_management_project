import 'package:emp_management/views/admin/component/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/global.dart';
import 'late_comes_list.dart';

class LateComersScreen extends StatefulWidget {
  @override
  _LateComersScreenState createState() => _LateComersScreenState();
}

class _LateComersScreenState extends State<LateComersScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff73AB6B),
        iconTheme: IconThemeData(color: whiteColor),
        title: Text(
          "Late Comers",
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
            padding: EdgeInsets.all(10.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.black26),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat("dd-MMM-yyyy").format(selectedDate),
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54,
                          ),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(left: 5.w),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.all(8.0.r),
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
                          text: ' 3  ',
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
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "CSV",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4053FF),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  "PDF",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4053FF),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Padding(
            padding:  EdgeInsets.only(left: 15.w,right: 15.w),
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
                Text(
                  'Time In',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                  SizedBox(width: 15.w,),
                Text(
                  'Late By',
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
          Expanded(
            child: ListView.builder(
              itemCount: lateComers.length,
              itemBuilder: (context, index) {
                final emp = lateComers[index];
                return ListTile(
                  title: Text(
                    emp['name'],
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "UI/UX Designer",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  trailing: Padding(
                    padding:  EdgeInsets.all(8.0.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          emp['timeIn'],
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        SizedBox(
                          width: 55.w,
                          child: Text(
                            emp['lateBy'],
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
