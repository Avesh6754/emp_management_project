import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectEmployeeAndSupervisor extends StatelessWidget {
  const SelectEmployeeAndSupervisor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 40.sp,
        children: [
          Container(
            height: 500.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffF5F9EF),
              image: DecorationImage(
                image: AssetImage('assets/image/4356046-removebg-preview.png'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/option');
                },
                child: empAndSupMethod(
                  icon: Icons.person_2_outlined,
                  title: "Employee",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/admin');
                },
                child: empAndSupMethod(
                  icon: Icons.person_2,
                  title: "Supervisor",
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: Image(
              image: AssetImage("assets/image/splash.jpeg"),
            ),
          )
        ],
      ),
    );
  }
}

Container empAndSupMethod({required IconData icon, required String title}) {
  return Container(
    height: 100.h,
    width: 100.w,
    decoration: BoxDecoration(color: Color(0xff73AB6B), shape: BoxShape.circle),
    child: Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Icon(
          icon,
          size: 50.sp,
          color: Colors.white,
        ),
        Text(
          title,
          style: GoogleFonts.roboto(textStyle: TextStyle(
            color: Colors.white,
          ),)
        )
      ],
    ),
  );
}
