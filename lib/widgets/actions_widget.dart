import 'package:flutter/material.dart';
import 'package:to_do_clone/res/theme.dart';

class ActionWidget extends StatefulWidget {
  final IconData? icon;
  final String action;
  final String? routeName;
  final Color? iconColor;
  final int? counter;
  
  const ActionWidget(
      {super.key,
      required this.action,
      this.icon,
      this.counter = 0,
      this.routeName,
      this.iconColor});

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(widget.routeName!),
      leading: Icon(
        widget.icon,
        color: widget.iconColor,
      ),
      title: Text(
        widget.action,
        style: ThemeMode.system == ThemeMode.light
            ? lightTheme.textTheme.bodySmall
            : darkTheme.textTheme.bodySmall,
      ),
      trailing: Text(
        '${widget.counter}',
        style: ThemeMode.system == ThemeMode.light
            ? lightTheme.textTheme.bodySmall
            : darkTheme.textTheme.bodySmall,
      ),
    );
  }
}
