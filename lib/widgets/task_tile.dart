import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/providers/task.dart';
import 'package:to_do_clone/providers/task_tile.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final int id;
  final Color color;
  final Task task;

  const TaskTile({
    super.key,
    required this.id,
    required this.color,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskTileState>(context);
    return ListTile(
      key: ValueKey(id),
      selected: true,
      selectedTileColor: Colors.white12,
      leading: IconButton(
        onPressed: () {
          taskState.done();
        },
        icon: Icon(
          taskState.isDone ? Icons.circle : Icons.circle_outlined,
          color: color,
        ),
      ),
      title: Text(
        task.task,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () {
          taskState.starred();
        },
        icon: Icon(
          taskState.isStarred ? Icons.star : Icons.star_border,
          color: color,
        ),
      ),
    );
  }
}
