import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class D2AdminLightTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

// make the whole app theme use roboto google font
  static ThemeData buildTheme() {
    return lightTheme.copyWith(
        textTheme: GoogleFonts.robotoTextTheme(lightTheme.textTheme));
  }
}
