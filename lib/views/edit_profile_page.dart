import 'package:emp_management/controller/auth_controller.dart';
import 'package:emp_management/modal/employee_request.dart';
import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/services/collection_of_attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<AuthController>(context, listen: true);
    var providerFalse = Provider.of<AuthController>(context, listen: false);

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
        child: SingleChildScrollView(
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
              _buildTextField("name", providerTrue.txtName, true),
              _buildTextField(
                  AuthServices.authServices.currentUser()!.email.toString(),
                  TextEditingController(),
                  false),
              _buildTextField("position", providerTrue.txtRoll, true),
              _buildTextField("status", providerTrue.txtStatus, true),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  AddDetails add = AddDetails(
                    date:
                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    name: providerTrue.txtName.text,
                    email: AuthServices.authServices.currentUser()!.email!,
                    position: providerTrue.txtRoll.text,
                    status: providerTrue.txtStatus.text,
                  );

                  CollectionOfAttendance.collectionAttendance.addDetails(add,
                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
                },
                child: Container(
                  height: 55.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Colors.green),
                  alignment: Alignment.center,
                  child: Text(
                    'Update',
                    style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20.sp)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, var controller, bool enabled) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextField(
        controller: (enabled) ? null : controller,
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
        enabled: enabled,
      ),
    );
  }
}
