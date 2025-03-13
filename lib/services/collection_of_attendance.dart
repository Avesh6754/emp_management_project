// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emp_management/modal/collection_of_attendance.dart';
//
// class CollectionOfAttendance {
//   CollectionOfAttendance._();
//
//   static CollectionOfAttendance collectionAttendance =
//       CollectionOfAttendance._();
//   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
//   Future<void> addCollectionEmployee(
//       CollectionOfAttendanceDate employee) async {
//     await _fireStore
//         .collection("attendance");
//   }
//
//   Future<void> update(
//       {required String date,
//       required String checkOut,
//       required String email}) async {
//     await _fireStore
//         .collection("Collection Of Attendance")
//         .doc(date)
//         .collection(email)
//         .doc("1")
//         .update({"checkOut": checkOut});
//   }
//
//   Future<DocumentSnapshot<Map<String, dynamic>>> oneDayDateShow({
//     required String date,
//   }) {
//     return _fireStore
//         .collection("Collection Of Attendance")
//         .doc(date).collection("18@gmail.com").doc("1").get();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/collection_of_attendance.dart';
import 'package:emp_management/modal/employee_request.dart';

class CollectionOfAttendance {
  CollectionOfAttendance._();

  static CollectionOfAttendance collectionAttendance =
      CollectionOfAttendance._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// todo : attendance list method

  Future<void> addCollectionEmployee(
      CollectionOfAttendanceModel employee, String day) async {
    _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .doc(employee.email)
        .set(
          CollectionOfAttendanceModel.toMap(employee),
        );
  }

  Future<void> updateCollectionEmployee(
      CollectionOfAttendanceModel employee, String day) async {
    _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .doc(employee.email)
        .update(
      {'checkOut': employee.checkOut},
    );
    Future<void> updateCollectionEmployeeReason(
        CollectionOfAttendanceModel employee, String day) async {
      _fireStore
          .collection("employee")
          .doc("attendance")
          .collection(day)
          .doc(employee.email)
          .update(
        {'reason': employee.reason},
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> oneDayEmployeeAttendance(
      {required String day}) {
    return _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .snapshots();
  }

  /// todo : details list method
  void addDetails(AddDetails add, String date) {
    _fireStore
        .collection("employee")
        .doc("details")
        .collection(date)
        .doc(add.email)
        .set(AddDetails.toMap(add));
  }

  void updateDetails({required AddDetails add}) {
    _fireStore
        .collection("employee")
        .doc("details")
        .collection(add.date)
        .doc(add.email)
        .update(AddDetails.toMap(add));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allEmployeeData(
      {required String date}) {
    return _fireStore
        .collection("employee")
        .doc("details")
        .collection(date)
        .snapshots();
  }
}
