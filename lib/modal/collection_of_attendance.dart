import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionOfAttendanceDate {
  List<CollectionOfAttendanceModel> collectionOfAttendanceModel = [];

  CollectionOfAttendanceDate({required this.collectionOfAttendanceModel});

  factory CollectionOfAttendanceDate.fromFirestore(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return CollectionOfAttendanceDate(
      collectionOfAttendanceModel: snapshot.docs
          .map((doc) => CollectionOfAttendanceModel.fromMap(doc.data()))
          .toList(),
    );
  }
}

class CollectionOfAttendanceModel {
  String? email,
      checkIn,
      checkOut,
      date,
      attendanceTime,
      reason,
      attendanceStatus;

  CollectionOfAttendanceModel({
    required this.email,
    required this.checkOut,
    required this.checkIn,
    required this.date,
    required this.attendanceTime,
    required this.attendanceStatus,
    required this.reason,
  });

  factory CollectionOfAttendanceModel.fromMap(Map m1) =>
      CollectionOfAttendanceModel(
        email: m1['email'],
        checkOut: m1['checkOut'],
        checkIn: m1['checkIn'],
        date: m1['date'],
        attendanceTime: m1['attendanceTime'],
        attendanceStatus: m1['attendanceStatus'],
        reason: m1['reason'],
      );

  static Map<String, Object?> toMap(CollectionOfAttendanceModel model) {
    return {
      'email': model.email,
      'date': model.date,
      'checkIn': model.checkIn,
      'checkOut': model.checkOut,
      'attendanceTime': model.attendanceTime,
      'attendanceStatus': model.attendanceStatus,
      'reason': model.reason
    };
  }
}
