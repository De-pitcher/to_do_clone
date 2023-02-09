// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/tasks.dart';
import '../widgets/task_details.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final AnimatedListState? animatedList;
  final RemovedItemBuilder<Task> buildRemovedItem;
  const TaskTile({
    Key? key,
    required this.task,
    required this.animation,
    required this.buildRemovedItem,
    this.animatedList,
  }) : super(key: key);

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
            child: Dismissible(
              key: UniqueKey(),
              dragStartBehavior: DragStartBehavior.start,
              background: Container(
                alignment: Alignment.centerRight,
                color: Theme.of(context).errorColor,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              onDismissed: (direction) {
                const duration = Duration(seconds: 3);
                int? currentTaskIndex =
                    context.read<Tasks>().removeTask(task, buildRemovedItem);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    duration: duration,
                    elevation: 0,
                    backgroundColor: Colors.white24,
                    content: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Task deleted',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<Tasks>()
                                  .insert(currentTaskIndex, task);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            child: const Text('UNDO'),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
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
        ),
        const SizedBox(height: 3),
      ],
    );
  }
}
