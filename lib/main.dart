import 'package:crimemapping/Screens/Welcome_screen.dart';
import 'package:crimemapping/Screens/login_screen.dart';
import 'package:crimemapping/Screens/signup_screen.dart';
import 'package:crimemapping/palette.dart';
import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // theme: ThemeData(fontFamily: 'Roboto Regular'),
      initialRoute: SplashScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
