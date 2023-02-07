import 'dart:async';

import "package:flutter/material.dart";
import 'package:to_do_clone/landing%20and%20auth/login.dart';
import 'package:to_do_clone/screens/landing.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.of(context).pushNamed(Login.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'To Do Clone',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
