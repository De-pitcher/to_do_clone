import 'package:flutter/material.dart';

class Planned extends StatefulWidget {
  static const String id = '/planned';
  const Planned({super.key});

  @override
  State<Planned> createState() => _PlannedState();
}

class _PlannedState extends State<Planned> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Center'),
    );
  }
}
