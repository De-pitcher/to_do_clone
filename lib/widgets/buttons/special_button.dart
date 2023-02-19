import 'package:flutter/material.dart';

class SpecialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onTap;
  const SpecialButton({
    required this.label,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(icon, color: Colors.white),
          label: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(width: 25)
      ],
    );
  }
}
