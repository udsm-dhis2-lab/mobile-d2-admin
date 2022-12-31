import 'package:flutter/material.dart';

class D2AdminLightTheme {
  static TextTheme lightTextTheme = const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
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
}
