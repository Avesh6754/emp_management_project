import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
           Image.asset('assets/image/edit_profile.png'),
            SizedBox(height: 10),
            Text("Update profile",
                style: TextStyle(
                  fontSize: 30,
                )),
            SizedBox(height: 20),
            _buildTextField("Designation"),
            _buildTextField("Department"),
            _buildTextField("Team Name"),
            _buildTextField("Supervised By"),
            _buildTextField("Phone Number"),
            SizedBox(height: 20),
           Container(
             height: 55,
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(15),
               color: Colors.green
             ),
             alignment: Alignment.center,
             child: Text('Update',style: TextStyle(color: Colors.white,fontSize: 20),),
           ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(8,),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
