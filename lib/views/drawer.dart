
import 'package:emp_management/views/component/app_bar_udf.dart';

import 'package:flutter/material.dart';


import 'component/drawer_udf.dart';
import 'home_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      drawer:SideMenu(),
      body: Center(child: CheckInOutScreen()),
    );
  }
}


