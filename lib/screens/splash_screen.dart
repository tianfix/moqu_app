import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moqu_app/screens/onboarding_screen.dart';
import 'package:moqu_app/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.push(context,
      MaterialPageRoute(builder:
      (context) => OnboardingScreen()));
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 88,
                    height: 88,
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'MoQu',
                    style: titleOnboarding.copyWith(color: Colors.white),
                  )
                ]
              ),
            ),
          )
        )
      ),
    );
  }
}