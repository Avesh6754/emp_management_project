
import 'package:emp_management/controller/auth_controller.dart';
import 'package:emp_management/controller/time_controller.dart';
import 'package:emp_management/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controller/emp_Controller.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), //this
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthController(),),
          ChangeNotifierProvider(create: (context) => EmpController(),),

          ChangeNotifierProvider(create: (context) => DateTimeProvider(),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: routes,
        ),
      ),
    );
  }
}
