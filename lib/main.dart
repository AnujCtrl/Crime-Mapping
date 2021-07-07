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
      themeMode: ThemeMode.system,
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
      ),
      // theme: ThemeData(fontFamily: 'Roboto Regular'),
      initialRoute: SplashScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
      },
    );
  }
}
