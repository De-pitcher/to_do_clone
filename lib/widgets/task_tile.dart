import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/task_details.dart';
import '../models/task.dart';
import '../providers/tasks.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  const TaskTile({
    super.key,
    required this.task,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizeTransition(
          axisAlignment: -1,
          sizeFactor: CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 0,
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  TaskDetails.id,
                  arguments: {
                    'color': Colors.deepPurple,
                    'parent': 'Tasks',
                    'taskValue': task.task,
                    'steps': task.step,
                    'id': task.id,
                  },
                );
              },
              tileColor: Colors.white24,
              leading: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: task.isDone,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  splashRadius: 35,
                  activeColor: Colors.deepPurple,
                  checkColor: Colors.black,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (_) {
                    context.read<Tasks>().toggleIsDone(task.id);
                  },
                ),
              ),
              title: Text(
                task.task,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
              ),
              trailing: IconButton(
                onPressed: () {
                  context.read<Tasks>().toggleIsStarred(task.id);
                },
                icon: Icon(
                  task.isStarred ? Icons.star : Icons.star_border,
                  color: task.isStarred ? Colors.deepPurple : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
      ],
    );
  }
}
