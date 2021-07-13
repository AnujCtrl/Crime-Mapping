import 'dart:async';

import 'package:crimemapping/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash_Screen';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: FlutterLogo(size: 20));
  }
}
