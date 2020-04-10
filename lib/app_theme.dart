import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const MaterialColor indigo = const MaterialColor(
    0xff424073,
    const <int, Color>{
      50: const Color(0xFFdcdce8),
      100: const Color(0xFFcbcad8),
      200: const Color(0xFFbab9cc),
      300: const Color(0xFFa9a8bf),
      400: const Color(0xFF53517f),
      500: const Color(0xff424073),
      600: const Color(0xFF312f54),
      700: const Color(0xFF24233f),
      800: const Color(0xFF1e1e35),
      900: const Color(0xFF06060b),
    },
  );

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xfff3f7f6),
      primaryColor: Color(0xff424073),
      accentColor: Color(0xffededf2),
      cursorColor: Color(0xff424073),
      textSelectionHandleColor: Color(0xff424073),
      primarySwatch: indigo,
      colorScheme: ColorScheme.light(
        primary: Color(0xff424073),
        onPrimary: Color(0xfff3f7f6),
        primaryVariant: Color(0xff757499),
        secondary: Color(0xff43c6ac),
        secondaryVariant: Color(0xffcbefe8),
        onSecondary: Color(0xfff3f7f6),
        error: Color(0xffa01111),
        onError: Color(0xfff3f7f6),
      ));
}
