import 'dart:developer';

import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../modal/attendence_model.dart';
import '../modal/collection_of_attendance.dart';
import '../modal/employee_request.dart';
import '../services/add_fire_store_attendwnce.dart';

class EmpController extends ChangeNotifier {
  String? empName, empEmail, empCheckIn, empCheckOut, empStatus, empAddress;
  double? empLatitude, empLongitude;
  String? emp_Reason;
  final User? user = AuthServices.authServices.currentUser();

  /// todo : list of one day emp data
  List<AddDetails> allEmployeeData = [];
  List<CollectionOfAttendanceModel> oneDateEmpList = [];

  bool isCheckedIn = false;
  bool isCheckedOut = false;
  int lastCheckInDate = 0;
  TextEditingController otherReasonController = TextEditingController();
  bool isOtherSelected = false;

  void updateCheckIn(String checkInTime) {
    empCheckIn = checkInTime;
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
      (isCheckedIn && !isCheckedOut)? CollectionOfAttendance.collectionAttendance.updateAddress(empAddress!, user!.email!, lastCheckInDate.toString(),empCheckIn! ):CollectionOfAttendance.collectionAttendance.updateAddressCheckout(empAddress!, user!.email!, lastCheckInDate.toString(),empCheckOut! );
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }


  void reasonMethod(String value) {
    emp_Reason = value;
    isOtherSelected = (value == "Others");
    notifyListeners();
  }


  /// Determine the user's location
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
