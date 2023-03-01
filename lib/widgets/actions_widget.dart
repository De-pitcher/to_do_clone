import 'package:flutter/material.dart';

import '../utils/res/theme.dart';

class ActionWidget extends StatefulWidget {
  final String activity;
  final String? routeName;
  final IconData? icon;
  final Color? iconColor;
  final int? counter;

  /// [ActionWidget] is a list tile for displaying each activity type
  const ActionWidget({
    super.key,
    required this.activity,
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
      onTap: () => Navigator.of(context).pushNamed(
        widget.routeName!,
        //* The color of the screen is passed from the landing
        //* page
        arguments: {
          'color': widget.iconColor,
          'activity': widget.activity,
        },
      ),
      leading: Icon(widget.icon, color: widget.iconColor),
      title: Text(
        widget.activity,
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
