import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/task_details.dart';
import '../models/task.dart';
import '../providers/tasks.dart';

class TaskTile extends StatelessWidget {
  // final Color color;
  final Task task;
  // final String? parent;
  const TaskTile({
    super.key,
    // this.parent,
    // required this.color,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          TaskDetails.id,
          // arguments: {
          //   'color': color,
          //   'parent': parent,
          //   'taskValue': task.task,
          //   'steps': task.step,
          // },
        );
      },
      // selected: true,
      // selectedTileColor: Colors.white12,
      tileColor: Colors.white12,
      // leading: IconButton(
      //   onPressed: () {
      //     context.read<Tasks>().toggleIsDone(task.id);
      //   },
      //   icon: Icon(
      //     task.isDone ? Icons.circle : Icons.circle_outlined,
      //     color: Colors.grey,
      //   ),
      // ),
      leading: SizedBox(
        width: 20,
        child: Checkbox(
          value: task.isDone,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          splashRadius: 50,
          onChanged: (_) {
            context.read<Tasks>().toggleIsDone(task.id);
          },
        ),
      ),
      title: Text(
        task.task,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white),
      ),
      // subtitle: Text(
      //   ' of ',
      //   style: Theme.of(context)
      //       .textTheme
      //       .bodySmall!
      //       .copyWith(color: Colors.white),
      // ),
      trailing: IconButton(
        onPressed: () {
          context.read<Tasks>().toggleIsStarred(task.id);
        },
        icon: Icon(
          task.isStarred ? Icons.star : Icons.star_border,
          color: task.isStarred ? Colors.deepPurple : Colors.grey,
        ),
      ),
    );
  }
}
