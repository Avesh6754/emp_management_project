import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Image.asset('assets/image/edit_profile.png'),
            SizedBox(height: 10.h),
            Text(
              "Update profile",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildTextField("Designation"),
            _buildTextField("Department"),
            _buildTextField("Team Name"),
            _buildTextField("Supervised By"),
            _buildTextField("Phone Number"),
            SizedBox(height: 20.h),
            Container(
              height: 55.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.green),
              alignment: Alignment.center,
              child: Text(
                'Update',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.white, fontSize: 20.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              GoogleFonts.roboto(textStyle: TextStyle(color: Colors.grey)),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(8.r),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
