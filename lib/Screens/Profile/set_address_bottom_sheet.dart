import 'package:crimemapping/Widgets/button_tile.dart';
import 'package:flutter/material.dart';
// import 'package:service_app/Widgets/button_tile.dart';
//
// import '../../../constants.dart';
import '../../palette.dart';

class SetAddressBottomSheet extends StatefulWidget {
  @override
  _SetAddressBottomSheetState createState() => _SetAddressBottomSheetState();
}

class _SetAddressBottomSheetState extends State<SetAddressBottomSheet> {
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
                ButtonTile(text: 'Set Address'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter Your Address',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'City',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Country',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: kSecondaryColor,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Set Location',
                    ),
                  ),
                ),
                Row(
                  children: [
                    ButtonTile(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      text: 'Save',
                    ),
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
