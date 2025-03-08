import 'package:emp_management/views/authh/admin_signin.dart';
import 'package:emp_management/views/component/location_udf.dart';
import 'package:flutter/material.dart';

import '../views/admin/attendance/attendance_page.dart';
import '../views/admin/drawer_page.dart';
import '../views/admin/early leavers/eraly_leavers.dart';
import '../views/admin/employyeList/employee.dart';
import '../views/admin/late_comes/late_comes.dart';
import '../views/authh/signIn_page.dart';
import '../views/authh/signUp_page.dart';
import '../views/authh/signUp_signIn_optipn.dart';
import '../views/drawer.dart';
import '../views/edit_profile_page.dart';
import '../views/home_page.dart';
import '../views/location_check/location_page.dart';
import '../views/select_employee_and_supervisor.dart';
import '../views/splash_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => SplashPage(),
  '/choose': (context) => SelectEmployeeAndSupervisor(),
  '/admin': (context) => AdminSignin(),
  '/option': (context) => OptionPage(),
  '/signIn': (context) => SigninPage(),
  '/signUp': (context) => SignupPage(),
  '/home': (context) => DrawerPage(),
  '/edit': (context) => UpdateProfileScreen(),
  '/location': (context) => OfficeLocationScreen(),
  '/check': (context) => FirstPage(),
  '/adminhome':(context)=> HomeScreen(),
  '/attendance':(context)=> AttendanceScreen(),
  '/lateComers':(context)=> LateComersScreen(),
  '/earlyLeave':(context)=> EarlyLeaversScreen(),
  '/employeeList':(context)=> EmployeeListScreen(),
};
