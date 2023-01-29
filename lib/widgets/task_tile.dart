import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/providers/task_tile.dart';
import 'package:to_do_clone/widgets/task_details.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Color color;
  final Task task;
  final String? parent;
  const TaskTile({
    super.key,
    this.parent,
    required this.color,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final taskState = Provider.of<TaskTileState>(context);
    // final demo = Provider.of<TaskList>(context);
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(TaskDetails.id, arguments: {
          'color': color,
          'parent': parent,
          'taskValue': task.task,
          'steps': task.steps,
          'rands': task
        });
      },
      selected: true,
      selectedTileColor: Colors.white12,
      leading: IconButton(
        onPressed: () {
          taskState.done();
        },
        icon: Icon(
          taskState.task.isDone ? Icons.circle : Icons.circle_outlined,
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
      subtitle: Text(
        ' of ',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () {
          taskState.starred();
        },
        icon: Icon(
          taskState.task.isStarred ? Icons.star : Icons.star_border,
          color: color,
        ),
      ),
    );
  }
}
