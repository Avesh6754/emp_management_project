import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/common_compo.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.h, left: 40.w),
            child: Container(
              height: 350.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/logoimage.png'),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/signIn');
            },
            child: commonButton(
                name: 'Sign In',
                color: greenColor,
                txtColor: whiteColor,
                boarderColor: greenColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/signUp');
            },
            child: commonButton(
                name: 'Sign Up',
                txtColor: greenColor,
                color: whiteColor,
                boarderColor: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, top: 5.h),
            child: Text(
              'Forgot Password ?',
              style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 15.sp)),
            ),
          )
        ],
      ),
    );
  }
}
