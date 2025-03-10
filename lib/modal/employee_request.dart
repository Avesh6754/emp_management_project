// class EmployeeRequest {
//   String id;
//   String name;
//   String email;
//   String department;
//   String position;
//   // double latitude;
//   // double longitude;
//   String status; // Pending, Approved, Rejected
//   DateTime requestedAt;
//
//   EmployeeRequest({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.department,
//     required this.position,
//     // required this.latitude,
//     // required this.longitude,
//     required this.status,
//     required this.requestedAt,
//   });
//
//   // Convert EmployeeRequest object to FireStore Map
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'department': department,
//       'position': position,
//       // 'location': {
//       //   'latitude': latitude,
//       //   'longitude': longitude,
//       // },
//       'status': status,
//       'requestedAt': requestedAt.toIso8601String(),
//     };
//   }
//
//   // Create EmployeeRequest object from FireStore Map
//   factory EmployeeRequest.fromMap(Map<String, dynamic> map, String id) {
//     return EmployeeRequest(
//       id: id,
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       department: map['department'] ?? '',
//       position: map['position'] ?? '',
//       // latitude: (map['location']?['latitude'] ?? 0.0).toDouble(),
//       // longitude: (map['location']?['longitude'] ?? 0.0).toDouble(),
//       status: map['status'] ?? 'Pending',
//       requestedAt: DateTime.parse(map['requestedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }
// }

class EmployeeRequest {
  String? email, name, password, status;

  EmployeeRequest({
    required this.email,
    required this.name,
    required this.status,
    required this.password,
  });

  factory EmployeeRequest.fromMap(Map m1) {
    return EmployeeRequest(
        email: m1['email'],
        name: m1['name'],
        status: m1['status'],
        password: m1['password']);
  }

  static Map<String, Object?> toMap(EmployeeRequest employee) {
    return {
      'email': employee.email,
      'name': employee.name,
      'password': employee.password,
      'status': employee.status,
    };
  }
}
