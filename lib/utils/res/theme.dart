import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  iconTheme: const IconThemeData(color: Colors.black),
  textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black)),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white),
  ),
);
