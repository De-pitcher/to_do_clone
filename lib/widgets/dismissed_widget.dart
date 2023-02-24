import 'package:flutter/material.dart';

class DismissedWidget extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final IconData icon;
  const DismissedWidget({
    Key? key,
    this.alignment,
    required this.color,
    this.padding,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      padding: padding,
      child: Icon(
        icon,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
