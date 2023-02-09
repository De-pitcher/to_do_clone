import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black),
        titleLarge: TextStyle(color: Colors.black),),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(fontSize: 14),
    ),
  );

  static UnderlineInputBorder underlineInputBorder(Color color) =>
      UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      );
}
