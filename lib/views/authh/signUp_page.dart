import 'package:emp_management/component/common_compo.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../component/textfiled_compo.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 180.h,
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
                isIcon: true, hint: 'Employee Name', icon: Icons.person),
            authtxtContainer(isIcon: true, hint: 'Email', icon: Icons.mail),
            authtxtContainer(
                isIcon: true, hint: 'password', icon: Icons.lock_rounded),
            SizedBox(
              height: 25.h,
            ),
            commonButton(
                name: 'Sign Up',
                color: greenColor,
                txtColor: whiteColor,
                boarderColor: greenColor),
            Padding(
              padding:  EdgeInsets.only(top: 8.h, right: 130.w),
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
            // TODO for create account with google..........................0.
            //TODO yaha pe digloue box banana baki he.............................
            Padding(
              padding:  EdgeInsets.only(right: 28.w, left: 28.w, top: 20.h),
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: greyColor),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/image/countiuneWithGoogle.png'))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
