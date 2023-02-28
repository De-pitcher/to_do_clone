import 'package:flutter/material.dart';


class TaskDetailsOptionWidget extends StatelessWidget {
  final String option;
  final IconData icon;
  final Function()? onTap;
  final Color color;
  final bool isEnable;
  const TaskDetailsOptionWidget({
    super.key,
    required this.option,
    required this.icon,
    this.onTap,
    required this.isEnable,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isEnable ? color : Colors.white38),
      title: Text(
        option,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: isEnable ? color : Colors.white38),
      ),
      trailing: isEnable
          ? const Icon(
              Icons.cancel,
              color: Colors.white38,
            )
          : null,
    );
  }
}
