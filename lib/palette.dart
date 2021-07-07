import 'package:flutter/material.dart';

Color kExtraDarkPrimaryColor = Color(0xFF231942);
Color kDarkPrimaryColor = Color(0xFF5e548e);

Color kPrimaryColor = Color(0xFF9f86c0);
Color kLightPrimaryColor = Color(0xFFbe95c4);
Color kExtraLightPrimaryColor = Color(0xFFe0b1cb);

Color kPrimaryTextColor = Color(0xFF212121);
Color kSecondaryTextColor = Color(0xFF757575);
Color kDividerColor = Color(0xFFBDBDBD);

Color kTextColor = Color(0xFFFFFFFF);

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),
  );

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
