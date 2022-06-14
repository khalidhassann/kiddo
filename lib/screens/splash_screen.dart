import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_v1/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/Main');
    });

    return new Scaffold(
      backgroundColor: AppColors.black,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/Logo_color.png',
              width: ScreenSize(context).width * 0.6,
              height: ScreenSize(context).height * 0.75,
            ),
            CircularProgressIndicator(color: AppColors.secondary)
          ],
        ),
      ),
    );
  }
}
