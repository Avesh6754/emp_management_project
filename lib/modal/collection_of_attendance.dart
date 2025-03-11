class CollectionOfAttendanceModel {
  String? email, checkIn, checkOut, date, attendanceTime;

  CollectionOfAttendanceModel(
      {required this.email,
      required this.checkOut,
      required this.checkIn,
      required this.date,
      required this.attendanceTime});

  factory CollectionOfAttendanceModel.fromMap(Map m1) =>
      CollectionOfAttendanceModel(
        email: m1['email'],
        checkOut: m1['checkOut'],
        checkIn: m1['checkIn'],
        date: m1['date'],
        attendanceTime: m1['attendanceTime'],
      );

  static Map<String, Object?> toMap(CollectionOfAttendanceModel model) {
    return {
      'email': model.email,
      'date': model.date,
      'checkIn': model.checkIn,
      'checkOut': model.checkOut,
      'attendanceTime': model.attendanceTime
    };
  }
}
