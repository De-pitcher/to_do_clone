import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.white10,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(fontSize: 14),
    ),
    // colorScheme: ColorScheme(
    //     brightness: Brightness.dark,
    //     secondary: Colors.white,
    //     onSecondary: Colors.white,
    //     onPrimary: Colors.white10,
    //     primary: Colors.white,
    //     background: Colors.white10),
  );

  static UnderlineInputBorder underlineInputBorder(Color color) =>
      UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      );
}
