import 'package:emp_management/component/common_compo.dart';
import 'package:emp_management/utils/global.dart';
import 'package:flutter/material.dart';
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
              height: 180,
            ),
            Text(
              "Sign Up for Better Experience",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            authtxtContainer(
                isIcon: true, hint: 'Employee Name', icon: Icons.person),
            authtxtContainer(isIcon: true, hint: 'Email', icon: Icons.mail),
            authtxtContainer(
                isIcon: true, hint: 'password', icon: Icons.lock_rounded),
            SizedBox(
              height: 25,
            ),
            commonButton(
                name: 'Sign Up',
                color: greenColor,
                txtColor: whiteColor,
                boarderColor: greenColor),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 130),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/signIn');
                },
                child: RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                            text: ' Sign In',
                            style: GoogleFonts.roboto(
                                color: greenColor, fontSize: 15))
                      ]),
                ),
              ),
            ),
            // TODO for create account with google..........................0.
            //TODO yaha pe digloue box banana baki he.............................
            Padding(
              padding: const EdgeInsets.only(right: 28, left: 28, top: 20),
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
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
