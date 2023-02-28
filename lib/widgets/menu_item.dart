import 'package:flutter/material.dart';

class PopMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? width;
  const PopMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 500,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
