import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var time = 0;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        setState(() {
          if (mounted) {
            setState(() {
              time = timer.tick;
              Navigator.of(context).pushReplacementNamed('/choose');
            });
          }
        });
      },
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
  _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 200.h, left: 50.w),
            child: Container(
              height: 450.h,
              width: 450.w,
              decoration: BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/logoimage.png'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150.h,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 30.w, right: 30.w),
            child: LinearProgressIndicator(
              value: time / 1.5,
              color: Colors.green,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),
    );
  }
}
