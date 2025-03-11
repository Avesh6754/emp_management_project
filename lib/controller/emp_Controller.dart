import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../modal/attendence_model.dart';
import '../services/add_fire_store_attendwnce.dart';

class EmpController extends ChangeNotifier {
  String? empName, empEmail, empCheckIn, empCheckOut, empStatus, empAddress;
  double? empLatitude, empLongitude;

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

  Future<void> checkLocation() async {
    AttendanceModel employee = AttendanceModel(
        email: empEmail,
        status: 'Present',
        name: empName,
        checkIn: DateTime.now().toIso8601String(),
        checkOut: '',
        lat: empLatitude,
        long: empLongitude,
        address: empAddress);
    await AddFireStoreAttendance.addAttendance.addEmployeeRequest(employee);
  }
}
