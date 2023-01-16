import 'package:flutter/material.dart';

class NewListThemeCard extends StatelessWidget {
  final Color color;
  final bool isEnabled;
  final String text;
  final Function()? onPressed;
  const NewListThemeCard({
    required this.color,
    required this.isEnabled,
    required this.text,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 35,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: isEnabled ? null : Border.all(color: color, width: 2),
          color: isEnabled ? color : Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isEnabled ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
