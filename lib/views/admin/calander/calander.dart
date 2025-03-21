import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AttendanceLogScreen extends StatefulWidget {
  const AttendanceLogScreen({Key? key}) : super(key: key);

  @override
  _AttendanceLogScreenState createState() => _AttendanceLogScreenState();
}

class _AttendanceLogScreenState extends State<AttendanceLogScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, Color> _attendanceData = {};


  /// Map attendance statuses to colors
  Color _getAttendanceColor(String status) {
    switch (status) {
      case "Present":
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
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Attendance Log"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          _buildLegend(),
          _buildCalendar(),
        ],
      ),
    );
  }

  /// Attendance Legend
  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 10,
        children: [
          _legendItem(Colors.green, "Present"),
          _legendItem(Colors.red, "Absent"),
          _legendItem(Colors.red, "Leave"),
          _legendItem(Colors.grey, "Week Off"),
          _legendItem(Colors.pinkAccent, "Late"),
          _legendItem(Colors.purple, "Early"),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// Calendar UI
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          return _buildDayCell(date);
        },
      ),
    );
  }

  /// Day Cell Styling
  Widget _buildDayCell(DateTime date) {
    Color? bgColor = _attendanceData[date];

    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.black38,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          DateFormat('d').format(date),
          style: TextStyle(
            fontSize: 16,
            color: bgColor == Colors.white ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
