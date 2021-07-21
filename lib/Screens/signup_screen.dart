import 'package:crimemapping/Widgets/button_tile.dart';
import 'package:crimemapping/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../palette.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'Sign Up Screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password1;
  String password2;
  bool passwordBool1 = true;
  bool passwordBool2 = true;
  @override
  void initState() {
    // TODO: implement initState
    passwordBool1 = true;
    passwordBool2 = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 0.35 * height,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: kGradientColor)),
              ),
              Container(
                color: kBackGroundColor,
                height: 0.65 * height,
                width: double.infinity,
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 8),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            cursorColor: kPrimaryColor,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Email Address',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TextField(
                            onChanged: (value) {
                              password1 = value;
                            },
                            obscureText: passwordBool1,
                            cursorColor: kPrimaryColor,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    passwordBool1 =
                                        passwordBool1 ? false : true;
                                  });
                                },
                                icon: passwordBool1
                                    ? Icon(
                                        CupertinoIcons.eye_slash_fill,
                                        size: 16,
                                        color: kTextColor,
                                      )
                                    : Icon(
                                        CupertinoIcons.eye_fill,
                                        size: 16,
                                        color: kTextColor,
                                      ),
                                label: SizedBox(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TextField(
                            onChanged: (value) {
                              password2 = value;
                            },
                            obscureText: passwordBool2,
                            cursorColor: kPrimaryColor,
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    passwordBool2 =
                                        passwordBool2 ? false : true;
                                  });
                                },
                                icon: passwordBool2
                                    ? Icon(
                                        CupertinoIcons.eye_slash_fill,
                                        size: 16,
                                        color: kTextColor,
                                      )
                                    : Icon(
                                        CupertinoIcons.eye_fill,
                                        size: 16,
                                        color: kTextColor,
                                      ),
                                label: SizedBox(),
                              ),
                            ),
                          ),
                        ),
                        passError()
                            ? getMessage()
                            : Text(
                                'Password should at least have 6 Characters'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: ButtonTile(
                            onPress: () {
                              if (!passError()) {
                                print('done afs');
                                signUp(email, password1, context).whenComplete(
                                  () => Navigator.pushNamed(
                                      context, LoginScreen.id),
                                );
                              }
                            },
                            text: 'Continue',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  bool passError() {
    bool passError;
    if (password1 != password2) {
      setState(() {
        passError = true;
      });
    } else {
      passError = false;
    }
    return passError;
  }

  Text getMessage() {
    return Text(
      'Passwords do not match',
      style: TextStyle(color: Colors.red),
    );
  }
}
