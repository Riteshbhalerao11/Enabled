import 'package:flutter/material.dart';

class Pallete {
// Colors
  static const primaryAppColor = Color(0xFF4ECDE8);
  static const accentappColor = Color(0xFF6459E1);
  static const labelTextColor = Color(0xFF757575);
  static const buttonColor = Color(0xFF882ECE);

//Theme
  static var lightModeAppTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: primaryAppColor,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: labelTextColor),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: const ColorScheme.light(
          primary: primaryAppColor,
          secondary: accentappColor,
          onPrimary: buttonColor,
          onPrimaryContainer: Colors.white,
          onSecondaryContainer: Colors.black));
}
