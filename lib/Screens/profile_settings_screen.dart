import 'package:crimemapping/Model/userclass.dart';
import 'package:crimemapping/Widgets/button_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../palette.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'Profile Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserProfile userProfile = UserProfile();
  User loggedInUser;
  int gender;
  @override
  void initState() {
    getCurrentUser();
    userProfile.gender = 0;
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        userProfile.email = loggedInUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: kGradientColor,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: kGradientColor),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topRight: Radius.zero,
                  topLeft: Radius.zero),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/background1.jpg'),
                      radius: 80,
                    ),
                  ),
                  ButtonTile(
                    text: 'CHANGE',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kBackGroundColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 32),
                                child: Text('Personal Information',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 80.0),
                              //   child: TextButton(
                              //     child: Icon(
                              //       Icons.edit,
                              //       color: kPrimaryColor,
                              //     ),
                              //     // child: Image(
                              //     //   height: 24,
                              //     //   width: 24,
                              //     //   image: AssetImage('images/edit (1)@3x.png'),
                              //     // ),
                              //     onPressed: () {
                              //       showModalBottomSheet<void>(
                              //         context: context,
                              //         builder: (BuildContext context) =>
                              //             PersonalInfoBottomSheet(),
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              cursorColor: kSecondaryColor,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Full Name',
                              ),
                              onChanged: (value) {
                                userProfile.name = value;
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: TextField(
                          //     keyboardType: TextInputType.emailAddress,
                          //     cursorColor: kSecondaryColor,
                          //     decoration: kTextFieldDecoration.copyWith(
                          //       labelText: 'Email Id',
                          //     ),
                          //     onChanged: (value) {
                          //       userProfile.email = value;
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              cursorColor: kSecondaryColor,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Mobile Number',
                              ),
                              onChanged: (value) {
                                userProfile.phoneNo = int.parse(value);
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Gender',
                                style:
                                    TextStyle(color: kTextColor, fontSize: 16),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                activeColor: kPrimaryColor,
                                groupValue: userProfile.gender,
                                onChanged: (int val) {
                                  setState(() {
                                    userProfile.gender = val;
                                  });
                                },
                              ),
                              Text(
                                'Male',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              Radio(
                                value: 2,
                                activeColor: kPrimaryColor,
                                groupValue: userProfile.gender,
                                onChanged: (int val) {
                                  setState(() {
                                    userProfile.gender = val;
                                  });
                                },
                              ),
                              Text(
                                'Female',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 32),
                                child: Text('Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              cursorColor: kSecondaryColor,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Home Address',
                              ),
                              onChanged: (value) {
                                userProfile.homeAddress = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              cursorColor: kSecondaryColor,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Emergency Contact No',
                              ),
                              onChanged: (value) {
                                userProfile.emerPhoneNo = int.parse(value);
                              },
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: ButtonTile(
                                onPress: () {
                                  print(userProfile.name);
                                  print(userProfile.email);
                                  print(userProfile.phoneNo);
                                  print(userProfile.gender);
                                  print(userProfile.homeAddress);
                                  print(userProfile.emerPhoneNo);
                                  _firestore.collection('user').add({
                                    'email': userProfile.email,
                                    'emerPhoneNo': userProfile.emerPhoneNo,
                                    'gender': userProfile.gender,
                                    'homeAddress': userProfile.homeAddress,
                                    'name': userProfile.name,
                                    'phoneNo': userProfile.phoneNo,
                                  });
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                                text: '           Save           ',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
