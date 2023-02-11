import 'package:flutter/material.dart';

class MyDay extends StatefulWidget {
  static const String id = '/my_day';
  const MyDay({super.key});

  @override
  State<MyDay> createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // image: DecorationImage(image: AssetImage())
          ),
      child: Column(
        children: [],
      ),
    );
  }
}
