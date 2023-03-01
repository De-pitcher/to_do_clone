import 'package:flutter/material.dart';

class TaskDetailsOptionWidget extends StatelessWidget {
  final String option;
  final IconData icon;
  final Function()? onTap;
  final Color color;
  final bool isEnabled;
  const TaskDetailsOptionWidget({
    super.key,
    required this.option,
    required this.icon,
    this.onTap,
    required this.isEnabled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isEnabled ? color : Colors.white38),
      title: Text(
        option,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: isEnabled ? color : Colors.white38),
      ),
      trailing: isEnabled
          ? const Icon(
              Icons.cancel,
              color: Colors.white38,
            )
          : null,
    );
  }
}
