import 'package:crimemapping/Widgets/button_tile.dart';
import 'package:flutter/material.dart';

import '../../palette.dart';

class PersonalInfoBottomSheet extends StatefulWidget {
  @override
  _PersonalInfoBottomSheetState createState() =>
      _PersonalInfoBottomSheetState();
}

class _PersonalInfoBottomSheetState extends State<PersonalInfoBottomSheet> {
  int gender;
  @override
  void initState() {
    gender = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF000014),
        child: Container(
          decoration: BoxDecoration(
            color: kBackGroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              children: [
                ButtonTile(text: 'Personal Information'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Email Id',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Mobile Number',
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Gender',
                      style: TextStyle(color: kTextColor, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      activeColor: kPrimaryColor,
                      groupValue: gender,
                      onChanged: (int val) {
                        setState(() {
                          gender = val;
                          print(gender);
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
                      groupValue: gender,
                      onChanged: (int val) {
                        setState(() {
                          gender = val;
                          print(gender);
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
                    ButtonTile(
                        onPress: () {
                          Navigator.pop(context);
                        },
                        text: 'Save'),
                    ButtonTile(
                        onPress: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
