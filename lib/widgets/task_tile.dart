import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskTile extends StatefulWidget {
  final Color? color;
  final Task? task;
  const TaskTile({super.key, this.color, this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      selectedTileColor: Colors.black12,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.circle_outlined,
          color: widget.color!,
        ),
      ),
      title: Text(
        '${widget.task!.task}',
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white24),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.star_outline,
          color: widget.color,
        ),
      ),
    );
  }
}
