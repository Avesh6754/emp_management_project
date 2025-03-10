import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/attendence_model.dart';

class AddFireStoreAttendance {
  AddFireStoreAttendance._();

  static AddFireStoreAttendance addAttendance = AddFireStoreAttendance._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addEmployeeRequest(AttendanceModel employee) async {
    await _fireStore
        .collection("Employee Attendance")
        .doc(employee.email)
        .set(AttendanceModel.toMap(employee));
  }
}
