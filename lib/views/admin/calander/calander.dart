import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceLogScreen extends StatefulWidget {
  @override
  _AttendanceLogScreenState createState() => _AttendanceLogScreenState();
}

class _AttendanceLogScreenState extends State<AttendanceLogScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, Color> _attendanceData = {
    DateTime(2025, 3, 1): Colors.green,
    DateTime(2025, 3, 3): Colors.red,
    DateTime(2025, 3, 4): Colors.pinkAccent,
    DateTime(2025, 3, 5): Colors.blue,
    DateTime(2025, 3, 6): Colors.purple,
    DateTime(2025, 2, 28): Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        leading:IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon:  Icon(Icons.arrow_back,color: Colors.white,),)
      ),
      body: Column(

        children: [
          SizedBox(height: 10.sp,),
          Text(
            "Attendance Log",
            style: GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xff414042),fontSize:24.sp )),
          ),
          Divider(color: Colors.black,),
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Wrap(
              spacing: 10.w,
              children: [
                _buildLegend("Present", Colors.green),
                _buildLegend("Absent", Colors.red),
                _buildLegend("Leave", Colors.blue),
                _buildLegend("Week Off", Colors.grey),
                _buildLegend("Late", Colors.pinkAccent),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildLegend("Early", Colors.purple),
                ),
                _buildLegend("Late & Early", Colors.red),
              ],
            ),
          ),
          Divider(color: Colors.black,),

          Expanded(
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
                    margin: EdgeInsets.all(4.r),
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
    );
  }

  Widget _buildLegend(String text, Color color) {
    return Padding(
      padding:  EdgeInsets.all(5.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5.w),

          Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.w),
          Text(text, style: TextStyle(fontSize: 14.sp,color: Colors.black)),
        ],
      ),
    );
  }
}
