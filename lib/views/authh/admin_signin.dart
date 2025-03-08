import 'package:emp_management/component/common_compo.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfiled_compo.dart';

class AdminSignin extends StatelessWidget {
  const AdminSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Text(
                "Welcome Back!",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              Image.asset('assets/image/4705027-removebg-preview.png'),
              authtxtContainer(hint: 'Email',isIcon: false,icon:Icons.add),
              authtxtContainer(hint: 'Password',isIcon: false,icon:Icons.add),
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 5),
                child: Text(
                  'Forgot Password ?',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/adminhome');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commonButton(
                      name: 'Sign In',
                      color: greenColor,
                      txtColor: whiteColor,
                      boarderColor: greenColor),
                ),
              ),

              // TODO    if don't have an account then navigate sign up page..........
              Padding(
                padding: const EdgeInsets.only(top: 2,right: 130),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signUp');
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account?",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                              text: ' Sign Up',
                              style: GoogleFonts.roboto(color: greenColor,fontSize: 15)
                          )
                        ]
                    ),

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
