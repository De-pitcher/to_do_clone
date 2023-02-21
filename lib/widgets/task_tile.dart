// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/activity_type.dart';
import '../models/task.dart';
import '../providers/tasks.dart';
import '../widgets/task_details.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final Function(Task)? onAddTaskFn;
  final Function()? onRemoveFn;
  final Function()? onRemoveFromUiFn;
  final ActivityType activityType;
  const TaskTile({
    Key? key,
    required this.task,
    required this.animation,
    this.onRemoveFn,
    this.onAddTaskFn,
    this.activityType = ActivityType.non,
    this.onRemoveFromUiFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final tksProvider = context.read<Tasks>();
    const duration = Duration(seconds: 3);
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
      child: SizedBox(
        height: 70,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          color: Colors.black54,
          child: Dismissible(
            key: UniqueKey(),
            dragStartBehavior: DragStartBehavior.start,
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).errorColor,
              ),
              padding: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 25,
              ),
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.secondary,
              ),
              padding: const EdgeInsets.only(left: 10),
              child: const Icon(
                Icons.sunny,
                color: Colors.white,
                size: 25,
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                scaffoldMessenger.hideCurrentSnackBar();
                onRemoveFn!();
                scaffoldMessenger.showSnackBar(
                  snackbar(
                      duration: duration,
                      msg: 'Task deleted',
                      scaffoldMessenger: scaffoldMessenger,
                      onPressed: () {
                        onAddTaskFn!(task);
                        scaffoldMessenger.hideCurrentSnackBar();
                      }),
                );
              } else if (direction == DismissDirection.startToEnd) {
                tksProvider.toggleMyDay(task.id);
              }
            },
            child: SizedBox(
              height: 60,
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
                horizontalTitleGap: 0,
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
                      onRemoveFromUiFn!();
                      tksProvider.toggleIsDone(task.id);
                    },
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.task,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                    ),
                    task.myDay
                        ? Row(
                            children: [
                              const Icon(
                                Icons.sunny,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'My Day',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    tksProvider.toggleIsStarred(task.id);
                    if (task.isStarred == true &&
                        activityType == ActivityType.important) {
                      scaffoldMessenger.showSnackBar(
                        snackbar(
                          duration: duration,
                          msg: 'Task removed from Importance',
                          scaffoldMessenger: scaffoldMessenger,
                          onPressed: () {
                            tksProvider.StarTask(task.id);
                            scaffoldMessenger.hideCurrentSnackBar();
                          },
                        ),
                      );
                    }
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
      ),
    );
  }

  SnackBar snackbar({
    required Duration duration,
    required String msg,
    required ScaffoldMessengerState scaffoldMessenger,
    Function()? onPressed,
  }) {
    return SnackBar(
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
            Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text('UNDO'),
            )
          ],
        ),
      ),
    );
  }
}
