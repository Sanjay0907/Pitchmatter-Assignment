import 'package:flutter/material.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';

ThemeData HomlyThemeData() {
  return ThemeData(
    splashColor: transparent,
    highlightColor: transparent,
    scaffoldBackgroundColor: white,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 57.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Rubik',
        color: black,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
    ),
    useMaterial3: true,
  );
}
