import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/emp_Controller.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var empProvider = Provider.of<EmpController>(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: greenColor,
            padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40.sp, color: Colors.green),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30.w),
                    Text( "Hi, ${empProvider.user?.email ?? ''}",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/edit');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ],
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, "Home"),
          _buildDrawerItem(Icons.assignment, "Isuues"),

          // Typo retained as in image
          _buildDrawerItem(Icons.report, "Incident"),
          _buildDrawerItem(Icons.list, "Leaves"),
          _buildDrawerItem(Icons.lock, "Change Password"),
          GestureDetector(onTap: () async {
            await AuthServices.authServices.signOut();
            Navigator.of(context).pushReplacementNamed('/choose');
          },child: ListTile(
            leading: Icon(Icons.logout, color: Colors.black54),
            title: Text(
              'Log Out',
              style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.black54)),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.black54)),
      ),
      onTap: () {},
    );
  }
}
