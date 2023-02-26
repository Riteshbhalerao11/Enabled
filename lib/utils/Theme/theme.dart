import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());

class Pallete {
// Colors
  static const primaryAppColor = Color(0xFF4ECDE8);
  static const accentappColor = Color(0xFF6459E1);
  static const labelTextColor = Color(0xFF757575);
  static const buttonColor = Color(0xFF882ECE);
  static const primaryDarkAppColor = Color(0xFF333333);
  static const accentDarkappColor = Colors.black;

//Theme
  static var lightModeAppTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: primaryAppColor,
      cardColor: const Color(0xFF333333),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
              fontFamily: "SecularOne",
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 1.2)),
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
          onBackground: Color(0xFF333333),
          onPrimaryContainer: Colors.white,
          onSecondaryContainer: Colors.black));

  //Dark Mode
  static var darkModeAppTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: primaryDarkAppColor,
      cardColor: Colors.black,
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF333333),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
              fontFamily: "SecularOne",
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.2)),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF333333),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: labelTextColor),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: const ColorScheme.dark(
          primary: primaryDarkAppColor,
          secondary: accentDarkappColor,
          tertiary: Colors.white,
          onBackground: Colors.black,
          onPrimaryContainer: Colors.black,
          onSecondaryContainer: Colors.white));
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.light})
      : _mode = mode,
        super(Pallete.lightModeAppTheme) {
    getTheme();
  }
  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString("theme");
    if (theme == "light") {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString("theme", "light");
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', "bark");
    }
  }
}
