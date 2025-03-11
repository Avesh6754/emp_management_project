import 'package:flutter/material.dart';

import '../modal/employee_request.dart';

class AuthController extends ChangeNotifier {
  var txtName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  String name = '';

  List<EmployeeRequest> employeeRequestList = [];
}
