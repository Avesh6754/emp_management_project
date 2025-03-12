class AddDetails {
  // String id;
  String name;
  String email;
  String position;
  String status;
  String date;

  AddDetails({
    required this.date,
    required this.name,
    required this.email,
    required this.position,
    required this.status,
  });

  // Convert EmployeeRequest object to FireStore Map
  static Map<String, Object?> toMap(AddDetails details) {
    return {
      'date': details.date,
      'name': details.name,
      'email': details.email,
      'position': details.position,
      'status': details.status,
    };
  }

  // Create EmployeeRequest object from FireStore Map
  factory AddDetails.fromMap(Map m1) {
    return AddDetails(
      date: m1['date'],
      name: m1['name'],
      email: m1['email'],
      position: m1['position'],
      status: m1['status'],
    );
  }
}

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
