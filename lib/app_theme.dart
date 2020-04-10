import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // static Color _iconColor = Colors.redAccent.shade200;

  // static const Color _lightPrimaryColor = Colors.white;
  // static const Color _lightPrimaryVariantColor = Color(0XFFE1E1E1);
  // static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xfff3f7f6),
      primaryColor: Color(0xff424073),
      accentColor: Color(0xffededf2),
      cursorColor: Color(0xff424073),
      colorScheme: ColorScheme.light(
        primary: Color(0xff424073),
        secondary: Color(0xff43c6ac),
      )
      // primarySwatch: Colors.purple,
      // appBarTheme: AppBarTheme(

      //   color: _lightPrimaryVariantColor,
      //   iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      // ),
      // colorScheme: ColorScheme.light(
      //   primary: _lightPrimaryColor,
      //   primaryVariant: _lightPrimaryVariantColor,
      //   secondary: _lightSecondaryColor,
      //   onPrimary: _lightOnPrimaryColor,
      // ),
      // iconTheme: IconThemeData(
      //   color: _iconColor,
      // ),
      // textTheme: _lightTextTheme,
      );

  static final TextTheme _lightTextTheme = TextTheme(
    headline: _lightScreenHeadingStyle,
    body1: _lightScreenTaskNameStyle,
    body2: _lightScreenTaskDurationStyle,
  );

  static final TextStyle _lightScreenHeadingStyle = TextStyle(
      fontSize: 48.0, letterSpacing: 1.2, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskNameStyle =
      TextStyle(fontSize: 20.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDurationStyle =
      TextStyle(fontSize: 16.0, color: Colors.grey);
}
