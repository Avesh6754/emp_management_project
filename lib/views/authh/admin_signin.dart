import 'package:emp_management/component/common_compo.dart';
import 'package:emp_management/controller/auth_controller.dart';
import 'package:emp_management/services/auth_services.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../component/textfiled_compo.dart';

class AdminSignin extends StatelessWidget {
  const AdminSignin({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<AuthController>(context, listen: true);
    var providerFalse = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Text(
                "Welcome Back!",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 25.h, color: Colors.black),
                ),
              ),
              Image.asset('assets/image/4705027-removebg-preview.png'),

              /// todo deep add controller
              authtxtContainer(
                hint: 'Email',
                isIcon: false,
                icon: Icons.add,
                txtController: providerTrue.txtEmail,
              ),
              authtxtContainer(
                hint: 'Password',
                isIcon: false,
                icon: Icons.add,
                txtController: providerTrue.txtPassword,
              ),
              Padding(
                padding: EdgeInsets.only(right: 220.w, top: 5.h),
                child: Text(
                  'Forgot Password ?',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(fontSize: 15.sp, color: Colors.green),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String value = await AuthServices.authServices.signIn(
                    email: providerTrue.txtEmail.text,
                    password: providerTrue.txtPassword.text,
                  );


                    Navigator.of(context).pushReplacementNamed('/adminhome');


                    // final snackBar = SnackBar(
                    //   content: Text("Email or Password are wrong..."),
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar)
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: commonButton(
                      name: 'Sign In',
                      color: greenColor,
                      txtColor: whiteColor,
                      boarderColor: greenColor),
                ),
              ),

              // TODO    if don't have an account then navigate sign up page..........
              Padding(
                padding: EdgeInsets.only(top: 2.h, right: 130.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signUp');
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account?",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                        children: [
                          TextSpan(
                              text: ' Sign Up',
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
