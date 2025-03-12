import 'package:flutter/material.dart';

import '../modal/employee_request.dart';

class AuthController extends ChangeNotifier {
  var txtName = TextEditingController();
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var txtRoll = TextEditingController();
  var txtStatus = TextEditingController();
  String name = '';
  bool isUpdate=false;

  List<EmployeeRequest> employeeRequestList = [];

  void fixedProfile(var value)
  {
    isUpdate=!value;
    notifyListeners();
  }
}
