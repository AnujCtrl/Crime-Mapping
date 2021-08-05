import 'dart:io';

import 'package:flutter/material.dart';

class TestingProfile extends StatefulWidget {
  static String id = 'Testing Profile';
  @override
  _TestingProfileState createState() => _TestingProfileState();
}

class _TestingProfileState extends State<TestingProfile> {
  File sampleImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        // onPressed: getImage,
        child: Icon(Icons.add),
      ),
    );
  }
}
