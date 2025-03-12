import 'package:emp_management/component/common_compo.dart';
import 'package:emp_management/controller/auth_controller.dart';
import 'package:emp_management/modal/employee_request.dart';
import 'package:emp_management/services/add_fire_stor_employee_request.dart';
import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../component/textfiled_compo.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var providerFalse = Provider.of<AuthController>(context, listen: false);
    var providerTrue = Provider.of<AuthController>(context, listen: true);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Image(
                image: AssetImage(
                  "assets/image/logoimage.png",
                ),
                height: 150,
              ),
              Text(
                "Sign Up for Better Experience",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 25.sp, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              authtxtContainer(
                isIcon: true,
                hint: 'Employee Name',
                icon: Icons.person,
                txtController: providerTrue.txtName,
              ),
              authtxtContainer(
                isIcon: true,
                hint: 'Email',
                icon: Icons.mail,
                txtController: providerTrue.txtEmail,
              ),
              authtxtContainer(



                isIcon: true,
                hint: 'password',
                icon: Icons.lock_rounded,
                txtController: providerTrue.txtPassword,
              ),
              SizedBox(
                height: 25.h,
              ),

              /// todo for deep : sing up logic code ..................................................
              GestureDetector(
                onTap: () {
                  EmployeeRequest employee = EmployeeRequest(
                    email: providerTrue.txtEmail.text,
                    name: providerTrue.txtName.text,
                    status: "pending",
                    password: providerTrue.txtPassword.text,
                  );
                  providerTrue.name=providerTrue.txtName.text;
                  AddFireStoreEmployeeRequest.addFireStoreRequest
                      .addEmployeeRequest(employee);
                },
                child: commonButton(
                  name: 'Sign Up',
                  color: greenColor,
                  txtColor: whiteColor,
                  boarderColor: greenColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, right: 130.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signIn');
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Already have an account?",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                        children: [
                          TextSpan(
                              text: ' Sign In',
                              style: GoogleFonts.roboto(
                                  color: greenColor, fontSize: 15.sp))
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
