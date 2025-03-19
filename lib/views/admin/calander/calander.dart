import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceLogScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceLogScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, Color> _attendanceData = {};

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData(_focusedDay);
  }

  /// Fetch attendance data from Firestore
  void _fetchAttendanceData(DateTime selectedDate) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    FirebaseFirestore.instance
        .collection("employee")
        .doc("attendance")
        .collection(formattedDate)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        Map<DateTime, Color> tempData = {};

        for (var doc in snapshot.docs) {
          String status = doc["attendanceTime"]; // Assuming "status" exists in Firestore
          Color color = _getAttendanceColor(status);

          DateTime date = DateTime.parse(doc["date"]); // Assuming "date" exists in Firestore
          tempData[date] = color;
        }

        setState(() {
          _attendanceData = tempData;
        });
      }
    });
  }

  /// Helper function to get color based on status
  Color _getAttendanceColor(String status) {
    switch (status) {
      case "OnTime":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Leave":
        return Colors.blue;
      case "Week Off":
        return Colors.grey;
      case "Late":
        return Colors.pinkAccent;
      case "Early":
        return Colors.purple;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () {
        Navigator.of(context).pop();
      }, icon: Icon(Icons.arrow_back,color: whiteColor,)),backgroundColor: greenColor,title: Text("Attendance Log",style: TextStyle(color: whiteColor),)),
      body: SingleChildScrollView( // Prevents overflow issues
        child: Column(
          children: [

            Divider(color: Colors.black),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 10,
                children: [
                  _buildLegend("Present", Colors.green),
                  _buildLegend("Absent", Colors.red),
                  _buildLegend("Leave", Colors.blue),
                  _buildLegend("Week Off", Colors.grey),
                  _buildLegend("Late", Colors.pinkAccent),
                  _buildLegend("Early", Colors.purple),

                ],
              ),
            ),
            Divider(color: Colors.black),

            /// Use `SizedBox` instead of `Expanded`
            SizedBox(
              height: 400, // Set a height to avoid RenderFlex issues
              child: TableCalendar(
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _fetchAttendanceData(selectedDay);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    Color? color = _attendanceData[day];
                    return Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color ?? Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: color != null ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to build the legend
  Widget _buildLegend(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

