import 'package:flutter/material.dart';

class DaintyColors {
  DaintyColors._();

  static final primary = const Color(0xFF00A2FF);
  static final primaryLight = const Color(0xFF768fff);
  static final primaryDark = const Color(0xFF0039cb);

  static final secondary = const Color(0xFF88D498);
  static final secondaryLight = const Color(0xFF6EFFE8);
  static final secondaryDark = const Color(0xFF00b686);

  static final pastelGray = const Color(0xFFC6DABF);
  static final eggShell = const Color(0xFFF3E9D2);

  static final midnightGreen = const Color(0xFF114B5F);

  static final nearlyWhite = Color(0xFFFAFAFA);
  static final white = Color(0xFFFFFFFF);
  static final background = Color(0xFFF2F3F8);
  static final nearlyDarkBlue = Color(0xFF2633C5);

  static final nearlyBlue = Color(0xFF00B6F0);
  static final nearlyBlack = Color(0xFF213333);
  static final grey = Color(0xFF3A5160);
  static final darkGrey = Color(0xFF313A44);

  static final darkText = Color(0xFF253840);
  static final darkerText = Color(0xFF17262A);
  static final lightText = Color(0xFF4A6572);
  static final deactivatedText = Color(0xFF767676);
  static final dismissibleBackground = Color(0xFF364A54);
  static final spacer = Color(0xFFF2F2F2);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.tryParse(hexColor, radix: 16) ?? 00;
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
