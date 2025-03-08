import 'dart:async';

import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.only(top: 200, left: 50),
            child: Container(
              height: 450,
              width: 450,
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
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: LinearProgressIndicator(
              value: time / 1.5,
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
