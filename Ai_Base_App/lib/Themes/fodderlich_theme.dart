import 'package:flutter/material.dart';

class FooderlichTheme {
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.green;
  static const Color tertiaryColor = Colors.orange;

  static ThemeData light() {
    return ThemeData(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        elevation: 0, // Add this line to remove the bottom border of the AppBar
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ), //colorScheme: ColorScheme(background: Colors.white, brightness: null, primary: null),
    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      // ignore: deprecated_member_use
      backgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        elevation: 0, // Add this line to remove the bottom border of the AppBar
      ),
      textTheme: const TextTheme(
        // ignore: deprecated_member_use
        headline6: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        // ignore: deprecated_member_use
        headline1: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
    );
  }
}
