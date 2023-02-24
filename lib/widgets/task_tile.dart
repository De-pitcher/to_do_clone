// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/activity_type.dart';
import '../models/task.dart';
import '../providers/tasks.dart';
import '../widgets/task_details.dart';
import './task_text_widget.dart';
import './dismissed_widget.dart';

const duration = Duration(seconds: 3);

class TaskTile extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final Function(Task)? onAddTaskFn;
  final Function(Task)? onRemoveFn;
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
            secondaryBackground: DismissedWidget(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              color: Theme.of(context).errorColor,
              icon: Icons.delete,
            ),
            background: DismissedWidget(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              color: Theme.of(context).colorScheme.secondary,
              icon: Icons.sunny,
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                scaffoldMessenger.hideCurrentSnackBar();
                onRemoveFn!(task);
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
                    TaskTextWidget(
                      text: task.task,
                      context: context,
                      color: Colors.white,
                      isDone: task.isDone,
                    ),
                    activityType != ActivityType.myDay && task.myDay
                        ? Row(
                            children: [
                              const Icon(
                                Icons.sunny,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              TaskTextWidget(
                                text: 'My Day',
                                context: context,
                                color: Colors.grey,
                              ),
                            ],
                          )
                        : activityType == ActivityType.myDay && task.myDay
                            ? TaskTextWidget(
                                text: 'Tasks',
                                context: context,
                                color: Colors.grey,
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
                            tksProvider.starTask(task.id);
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
