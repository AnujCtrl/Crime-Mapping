import 'dart:async';

import 'package:crimemapping/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'Splash_Screen';
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool userToggle;
  @override
  void initState() {
    super.initState();
    getCurrentUser().then((value) {
      setState(() {
        userToggle = value;
      });
    });
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    userToggle ? HomeScreen() : WelcomeScreen())));
  }

  Future<bool> getCurrentUser() async {
    bool value;
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        value = true;
      } else {
        value = false;
      }
    } catch (e) {
      print(e);
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: FlutterLogo(size: 20));
  }
}
