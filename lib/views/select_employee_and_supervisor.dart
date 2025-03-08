import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectEmployeeAndSupervisor extends StatelessWidget {
  const SelectEmployeeAndSupervisor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 40,
        children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffF5F9EF),
              image: DecorationImage(
                image: AssetImage('assets/image/image_page3.png'),
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
            height: 5,
          ),
          Expanded(
            child: Image(
              image: AssetImage("assets/image/logo.png"),
            ),
          )
        ],
      ),
    );
  }
}

Container empAndSupMethod({required IconData icon, required String title}) {
  return Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(color: Color(0xff73AB6B), shape: BoxShape.circle),
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Icon(
          icon,
          size: 50,
          color: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}
