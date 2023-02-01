import 'package:flutter/material.dart';
import '../utils/res/theme.dart';

class ActionWidget extends StatefulWidget {
  final String action;
  final String? routeName;
  final IconData? icon;
  final Color? iconColor;
  final int? counter;

  const ActionWidget({
    super.key,
    required this.action,
    this.icon,
    this.iconColor,
    this.counter = 0,
    this.routeName,
  });

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed(widget.routeName!, arguments: widget.iconColor),
      leading: Icon(widget.icon, color: widget.iconColor),
      title: Text(
        widget.action,
        style: ThemeMode.system == ThemeMode.light
            ? AppTheme.lightTheme.textTheme.bodySmall
            : AppTheme.darkTheme.textTheme.bodySmall,
      ),
      trailing: Text(
        widget.counter == 0 ? '' : '${widget.counter}',
        style: ThemeMode.system == ThemeMode.light
            ? AppTheme.lightTheme.textTheme.bodySmall
            : AppTheme.darkTheme.textTheme.bodySmall,
      ),
    );
  }
}
