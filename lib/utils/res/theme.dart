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
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
    ),
  );

  static UnderlineInputBorder underlineInputBorder(Color color) =>
      UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      );
}
