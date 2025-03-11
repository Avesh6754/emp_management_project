import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/attendence_model.dart';

class AddFireStoreAttendance {
  AddFireStoreAttendance._();

  static AddFireStoreAttendance addAttendance = AddFireStoreAttendance._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addEmployee(AttendanceModel employee) async {
    await _fireStore
        .collection("Employee Attendance")
        .doc(employee.email)
        .set(AttendanceModel.toMap(employee));
  }

  Future<void> updateAttendanceCheckIn({
    required String email,
    required String address,
    required String checkIn,
    required String checkOut,
    required var lat,
    required var long,
    required String status,
  }) async {
    await _fireStore.collection("Employee Attendance").doc(email).update({
      "address": address,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "email": email,
      "lat": lat,
      "long": long,
      "status": status
    });
  }
  Future<void> updateAttendanceCheckOut({
    required String email,
    required String address,
    required String checkIn,
    required String checkOut,
    required var lat,
    required var long,
    required String status,
  }) async {
    await _fireStore.collection("Employee Attendance").doc(email).update({
      "address": address,
      "checkOut": checkOut,
      "email": email,
      "lat": lat,
      "long": long,
      "status": status
    });
  }
}
