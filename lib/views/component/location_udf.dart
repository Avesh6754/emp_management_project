import 'package:auto_size_text/auto_size_text.dart';
import 'package:emp_management/utils/global.dart';
import 'package:emp_management/views/component/app_bar_udf.dart';
import 'package:emp_management/views/component/static_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controller/emp_Controller.dart';
import '../../services/collection_of_attendance.dart';
import 'drawer_udf.dart';

class OfficeLocationScreen extends StatefulWidget {
  const OfficeLocationScreen({super.key});

  @override
  State<OfficeLocationScreen> createState() => _OfficeLocationScreenState();
}

class _OfficeLocationScreenState extends State<OfficeLocationScreen> {
  String? selectedReason;
  bool checkOut = false;

  @override
  void initState() {
    super.initState();

    /// Check the time when the screen loads
    Future.delayed(Duration.zero, () {

      ((context.watch<EmpController>().emp_Reason==null))?_checkAndShowDialog():null;
    });
  }

  void _checkAndShowDialog() {
    DateTime now = DateTime.now();
    DateTime nineThirtyAM =
        DateTime(now.year, now.month, now.day, 9, 30); // 9:30 AM

    if (now.isAfter(nineThirtyAM)) {
      _showLateDialog(); // Show the late dialog if checked in but not checked out
    }
  }

  Widget build(BuildContext context) {
    var empProviderTrue = Provider.of<EmpController>(context, listen: true);
    var empProviderFalse = Provider.of<EmpController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      drawer: SideMenu(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StaticDateTime(),
            SizedBox(height: 20.h),

            /// Status Message Based on Address
            Row(
              children: [
                Icon(
                  ((empProviderTrue.empAddress !=
                          "police station, Surat, Gujarat, India"))
                      ? Icons.warning
                      : ((empProviderTrue.empAddress !=
                              "Uma plaza Star Circle, Surat, Gujarat, India"))
                          ? Icons.check_circle
                          : Icons.warning,
                  color: ((empProviderTrue.empAddress !=
                          "police station, Surat, Gujarat, India"))
                      ? Colors.amber
                      : ((empProviderTrue.empAddress !=
                              "Uma plaza Star Circle, Surat, Gujarat, India"))
                          ? Colors.green
                          : Colors.amber,
                  size: 28.sp,
                ),
                SizedBox(width: 8.w),
                AutoSizeText(
                  'Status: ',
                  minFontSize: 18,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                AutoSizeText(
                  ((empProviderTrue.empAddress !=
                          "police station, Surat, Gujarat, India"))
                      ? 'You are not in office range'
                      : ((empProviderTrue.empAddress !=
                              "Uma plaza Star Circle, Surat, Gujarat, India"))
                          ? 'Now you are at NBR'
                          : "You are not in office range",
                  minFontSize: 18,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      color: ((empProviderTrue.empAddress !=
                              "police station, Surat, Gujarat, India"))
                          ? Colors.red
                          : ((empProviderTrue.empAddress !=
                                  "Uma plaza Star Circle, Surat, Gujarat, India"))
                              ? Colors.black
                              : Colors.red,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Map Placeholder
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: AssetImage("assets/image/map.png"),
                //     fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[300],
              ),
            ),

            SizedBox(height: 20.h),

            /// Display Current Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Colors.black),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    empProviderTrue.empAddress ?? 'Not found location',
                    style: GoogleFonts.roboto(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            /// Late Arrival Alert Dialog
            // ElevatedButton(
            //   onPressed: _showLateDialog, // Manually trigger the dialog
            //   child: const Text('Save'),
            // ),

            SizedBox(height: 20.h),
            Spacer(),

            /// Office Range Note
            ((empProviderTrue.empAddress !=
                    "police station, Surat, Gujarat, India"))
                ? Column(
                    children: [
                      Text(
                        "Note: Please go inside Office range then ",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          empProviderFalse.getCurrentLocation();
                          setState(() {}); // Reloads the screen
                        },
                        child: Text(
                          "Try Again!",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration
                                .underline, // Make it look clickable
                          ),
                        ),
                      ),
                    ],
                  )
                : ((empProviderTrue.empAddress !=
                        "Uma plaza Star Circle, Surat, Gujarat, India"))
                    ? Row(
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
                                context.watch<EmpController>().empCheckIn ==
                                        null
                                    ? "--:--"
                                    : context
                                        .watch<EmpController>()
                                        .empCheckIn!,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Check In',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
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
                              Text(
                                context.watch<EmpController>().empCheckOut ==
                                        null
                                    ? "--:--"
                                    : context
                                        .watch<EmpController>()
                                        .empCheckOut!,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Check Out',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.green,
                                size: 50.sp,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                '--:--',
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "Working Hr's",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            "Note: Please go inside Office range then ",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              empProviderFalse.getCurrentLocation();
                              setState(() {}); // Reloads the screen
                            },
                            child: Text(
                              "Try Again!",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration
                                    .underline, // Make it look clickable
                              ),
                            ),
                          ),
                        ],
                      ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  void _showLateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You are late!!!",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Icon(Icons.warning, color: Colors.red, size: 40.sp),
              SizedBox(height: 10.h),
              Text("Select a reason"),
              RadioListTile(
                title: Text("Traffic Jam"),
                value: "Traffic Jam",
                groupValue: context.watch<EmpController>().emp_Reason,
                activeColor: Colors.green,
                onChanged: (value) {
                  context.read<EmpController>().reasonMethod(value!);
                },
              ),
              RadioListTile(
                title: Text("Health Issue"),
                value: "Health Issue",
                groupValue: context.watch<EmpController>().emp_Reason,
                activeColor: Colors.green,
                onChanged: (value) {
                  context.read<EmpController>().reasonMethod(value!);
                },
              ),
              RadioListTile(
                title: Text("Others"),
                value: "Others",
                groupValue: context.watch<EmpController>().emp_Reason,
                activeColor: Colors.green,
                onChanged: (value) {
                  context.read<EmpController>().reasonMethod(value!);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () async {
                  // Debugging: Print current values
                  print("Selected Reason: ${context.read<EmpController>().emp_Reason}");
                  print("User Email: ${context.read<EmpController>().user?.email}");

                  if (context.read<EmpController>().emp_Reason == null ||
                      context.read<EmpController>().user?.email == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a reason before submitting!")),
                    );
                    return;
                  }

                  try {
                    await CollectionOfAttendance.collectionAttendance.updateCollectionEmployeeReason(
                      context.read<EmpController>().emp_Reason!,
                      context.read<EmpController>().user!.email!,
                      DateTime.now().day.toString(),
                    );

                    print("Attendance reason updated successfully!");
                    Navigator.pop(context);
                  } catch (e) {
                    print("Error updating reason: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update reason. Try again!")),
                    );
                  }
                },

                child: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }
}
