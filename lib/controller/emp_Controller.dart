import 'dart:developer';

import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/attendence_model.dart';
import '../modal/collection_of_attendance.dart';
import '../modal/employee_request.dart';
import '../services/add_fire_store_attendwnce.dart';

class EmpController extends ChangeNotifier {
  String? empName, empEmail, empCheckIn, empCheckOut, empStatus, empAddress;
  double? empLatitude, empLongitude;
  var total=0;
  String? emp_Reason;
  int? lastStoredCheckInDate;

  int selectedIndex=0;
  String selectedFilter = "Last 14 days"; // Default dropdown value
  List<String> days = [];
  final User? user = AuthServices.authServices.currentUser();

  /// todo : list of one day emp data
  List<AddDetails> allEmployeeData = [];
  List<CollectionOfAttendanceModel> oneDateEmpList = [];

  bool isCheckedIn = false;
  bool isCheckedOut = false;
  int lastCheckInDate = 0;
  TextEditingController otherReasonController = TextEditingController();
  bool isOtherSelected = false;

  void generateDateRange() {
    DateTime today = DateTime.now();
    days.clear();

    switch (selectedFilter) {
      case "Last 7 days":
        for (int i = 0; i < 7; i++) {
          days.add(DateFormat('yyyy-MM-dd').format(today.subtract(Duration(days: i))));
        }
        break;

      case "Last 14 days":
        for (int i = 0; i < 14; i++) {
          days.add(DateFormat('yyyy-MM-dd').format(today.subtract(Duration(days: i))));
        }
        break;

      case "Last 30 days":
        for (int i = 0; i < 30; i++) {
          days.add(DateFormat('yyyy-MM-dd').format(today.subtract(Duration(days: i))));
        }
        break;

      case "This month":
        DateTime firstDay = DateTime(today.year, today.month, 1);
        for (int i = 0; i <= today.difference(firstDay).inDays; i++) {
          days.add(DateFormat('yyyy-MM-dd').format(firstDay.add(Duration(days: i))));
        }
        break;

      case "Last month":
        DateTime firstDay = DateTime(today.year, today.month - 1, 1);
        DateTime lastDay = DateTime(today.year, today.month, 0);
        for (int i = 0; i <= lastDay.difference(firstDay).inDays; i++) {
          days.add(DateFormat('yyyy-MM-dd').format(firstDay.add(Duration(days: i))));
        }
        break;
    }
    notifyListeners();

    fetchAllAttendanceRecord(); // Fetch attendance records
  }


  Future<void> initializeCheckInStatus() async {
    for (var employee in oneDateEmpList) {
      lastCheckInDate=int.parse(employee.date!);
    }
    notifyListeners();
  }


  void changeSelectedIndex(var value)
  {
    selectedFilter=value;
    notifyListeners();
  }

  void totalWorkTime() {
    if (empCheckIn != null && empCheckOut != null) {
      DateTime checkIn = DateTime.parse(empCheckIn!);
      DateTime checkOut = DateTime.parse(empCheckOut!);

      Duration workDuration = checkOut.difference(checkIn);
      total = workDuration.inHours; // or use workDuration.inMinutes for minute-level precision

      notifyListeners();
    }
  }

  void updateCheckIn(String checkInTime) {
    empCheckIn = checkInTime;
    notifyListeners();
  }
  void updateIndex(int index)
  {selectedIndex=index;
    notifyListeners();
  }

  void updateCheckOut(String checkOutTime) {
    empCheckOut = checkOutTime;
    notifyListeners();
  }


  void setCheckInStatus(bool status,int currentDate) {
    isCheckedIn = status;

    lastCheckInDate = currentDate; // Store current date
    notifyListeners();
  }
  void setCheckOutStatus(bool status,) {

    isCheckedOut = status;
     // Store current date
    notifyListeners();
  }


  /// Get the current position
  Future<void> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      empLatitude = position.latitude;
      empLongitude = position.longitude;

      /// Convert lat/lng to address
      empAddress =
          await _getAddressFromCoordinates(empLatitude!, empLongitude!);
      log("===================$empAddress");
           notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<CollectionOfAttendanceModel>> fetchAllAttendanceRecord()
  async {
    List<CollectionOfAttendanceModel> records = await CollectionOfAttendance.collectionAttendance.fetchEmployeeAttendanceRecords(user!.email!, days);
    return records;
  }


  void reasonMethod(String value) {
    emp_Reason = value;
    isOtherSelected = (value == "Others");
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services are disabled.');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Convert latitude and longitude to an address
  Future<String> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        log("===========================$placemarks==================================");
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      print("Error getting address: $e");
    }
    return "Unknown Location";
  }


}
