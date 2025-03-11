class AttendanceModel {
  String? name, email, checkIn, checkOut, status,address;
  var long, lat;

  AttendanceModel({
    required this.email,
    required this.status,
    required this.name,
    required this.checkIn,
    required this.checkOut,
    required this.lat,
    required this.long,
    required this.address
  });

  factory AttendanceModel.fromMap(Map m1) {
    return AttendanceModel(
        email: m1['email'],
        status: m1['status'],
        name: m1['name'],
        checkIn: m1['checkIn'],
        checkOut: m1['checkOut'],
        address: m1['address'],
        lat: m1['lat'],
        long: m1['long']);
  }

  static Map<String, Object?> toMap(AttendanceModel model) {
    return {
      'name': model.name,
      'email': model.email,
      'lat': model.lat,
      'long': model.long,
      'address':model.address,
      'checkOut': model.checkOut,
      'checkIn': model.checkIn,
      'status': model.status,
    };
  }
}
