import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: greenColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.green),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30,),
                    Text("Hi! Kabir", style: TextStyle(color: Colors.white, fontSize: 18)),
                    IconButton(onPressed: () {
                      Navigator.of(context).pushNamed('/edit');
                    }, icon: Icon(Icons.edit,color: Colors.white,)),
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
          _buildDrawerItem(Icons.logout, "Log out"),

        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: TextStyle(color: Colors.black54)),
      onTap: () {},
    );
  }
}