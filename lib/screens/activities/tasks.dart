import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  static const String id = '/tasks';
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [SliverAppBar()],
    ));
  }
}
