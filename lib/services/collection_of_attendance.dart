import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/modal/collection_of_attendance.dart';

class CollectionOfAttendance {
  CollectionOfAttendance._();

  static CollectionOfAttendance collectionAttendance =
      CollectionOfAttendance._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addCollectionEmployee(
      CollectionOfAttendanceModel employee) async {
    await _fireStore
        .collection("Collection Of Attendance")
        .doc(employee.date)
        .collection(employee.email!)
        .doc("1")
        .set(CollectionOfAttendanceModel.toMap(employee));
  }

  Future<void> update(
      {required String date,
      required String checkOut,
      required String email}) async {
    await _fireStore
        .collection("Collection Of Attendance")
        .doc(date)
        .collection(email)
        .doc("1")
        .update({"checkOut": checkOut});
  }
}
