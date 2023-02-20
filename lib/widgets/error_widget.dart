import 'package:flutter/material.dart';

class AppError extends StatefulWidget {
  final String error;
  const AppError({super.key, required this.error});

  @override
  State<AppError> createState() => _AppErrorState();
}

class _AppErrorState extends State<AppError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 30,
      color: Colors.red[400],
      child: Center(
        child: Text(widget.error),
      ),
    );
  }
}
