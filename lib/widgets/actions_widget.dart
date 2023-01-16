import 'package:flutter/material.dart';

class ActionWidget extends StatefulWidget {
  final IconData? icon;
  final String action;
  final Color? iconColor;
  final int? counter;
  const ActionWidget(
      {super.key,
      this.icon,
      this.counter = 0,
      required this.action,
      this.iconColor});

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(
        widget.icon,
        color: widget.iconColor,
      ),
      title: Text(
        widget.action,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: Text(
        '${widget.counter}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
