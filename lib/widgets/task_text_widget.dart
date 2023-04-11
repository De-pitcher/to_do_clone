import 'package:flutter/material.dart';

class TaskTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final bool? isDone;
  const TaskTextWidget(
      {required this.text,
      required this.color,
      this.isDone = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
          color: color,
          decoration:
              isDone! ? TextDecoration.lineThrough : TextDecoration.none),
    );
  }
}
