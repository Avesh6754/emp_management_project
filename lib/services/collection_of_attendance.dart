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

  Future<void> updateCollectionEmployee(CollectionOfAttendanceModel employee,
      String day, String checkoutStatus) async {
    _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .doc(employee.email)
        .update(
      {
        'checkOut': employee.checkOut,
        'isCheckOut': employee.isCheckOut,
        'attendenceCheckouTime': employee.attendenceCheckouTime
      },
    );
  }

  Future<void> updateCollectionEmployeeReason(
      String reason, String email, String day) async {
    _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .doc(email)
        .update(
      {'reason': reason},
    );
  }

  Future<List<CollectionOfAttendanceModel>> fetchAttendanceData(
      String email) async {
    QuerySnapshot snapshot = await _fireStore
        .collection("employee")
        .doc(email)
        .collection("attendance")
        .get();
    return snapshot.docs
        .map((doc) => CollectionOfAttendanceModel.fromMap(
            doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> oneDayEmployeeAttendanceData(
      {required String day}) {
    return FirebaseFirestore.instance
        .collection("employee")
        .doc("attendance")
        .collection(day)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> progressDataFromFiresbase({
    required String start,
    required String end,
    required String email,
  }) {
    return _fireStore
        .collection("employee")
        .doc("attendance")
        .collection(start)
        .snapshots();
  }

  void updateAddress(
      String address, String email, String day, String checkInTime) {
    _fireStore
        .collection("employee")
        .doc('attendance')
        .collection(day)
        .doc(email)
        .update({'address': address, 'checkIn': checkInTime});
  }

  void updateAddressCheckout(
      String address, String email, String day, String checkInTime) {
    _fireStore
        .collection("employee")
        .doc('attendance')
        .collection(day)
        .doc(email)
        .update({'address': address, 'checkOut': checkInTime});
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
