import 'package:flutter/material.dart';

import 'colors.dart';

///
/// Flutter Color Theme
///
ThemeData buildDaintyTheme() {
  final ThemeData base = ThemeData.light();

  final String fontName = 'Roboto';

  final TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: DaintyColors.darkerText,
  );

  final TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: DaintyColors.darkerText,
  );

  final TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: DaintyColors.darkerText,
  );

  final TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: DaintyColors.darkText,
  );

  final TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: DaintyColors.darkText,
  );

  final TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: DaintyColors.darkText,
  );

  final TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: DaintyColors.lightText, // was lightText
  );

  final TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  return base.copyWith(
    accentColor: DaintyColors.secondaryLight,
    primaryColor: DaintyColors.primary,
    backgroundColor: Color.fromARGB(1, 250, 250, 250),
    buttonTheme: base.buttonTheme.copyWith(
      colorScheme: ColorScheme.light(),
      buttonColor: DaintyColors.secondary,
      splashColor: DaintyColors.primaryLight,
      shape: StadiumBorder(),
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: Color.fromARGB(1, 250, 250, 250),
    cardColor: DaintyColors.eggShell,
    textSelectionColor: Colors.orangeAccent,
    errorColor: Colors.red,
    // Add the color themes (103) here.
  );
}
