import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart'; // Import for formatting

class DateTimeProvider extends ChangeNotifier {
  String? _formattedTime;
  String? _onlyTime;

  String firstTime ='02:15 PM',lastTime='02:30 PM';


  DateTimeProvider() {
    _updateTime();
  }

  String? get formattedTime => _formattedTime;
  String? get onlyTime => _onlyTime;

  void _updateTime() {
    _formattedTime = _getCurrentISTFormatted();
    _onlyTime = _getCurrentISTTime();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _formattedTime = _getCurrentISTFormatted();
      _onlyTime = _getCurrentISTTime();
      notifyListeners();
    });
  }

  /// Returns time + date (formatted)
  String _getCurrentISTFormatted() {
    DateTime istTime = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('        hh:mm a\nEEEE, MMMM d').format(istTime);
  }
  bool isTimeBetween(String checkTime, String firstTime, String lastTime) {
    final DateFormat format = DateFormat('hh:mm a');

    DateTime check = format.parse(checkTime);
    DateTime start = format.parse(firstTime);
    DateTime end = format.parse(lastTime);

    return check.isAfter(start) && check.isBefore(end);
  }

  /// Returns only time (formatted)
  String _getCurrentISTTime() {
    DateTime istTime = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('hh:mm a').format(istTime); // Format: 10:30 PM
  }



  void checkTimeOut()
  {
    debugPrint('day Namd :::::$onlyTime');

    if (isTimeBetween(onlyTime!, firstTime, lastTime)) {
      print('Checkout time is within the range.');
    } else {
      print('Checkout time is outside the range.');
    }
  }


}
