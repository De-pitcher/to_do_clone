import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/activity_type.dart';
import '../models/task.dart';
import '../providers/remind_me_list.dart';
import '../providers/tasks.dart';
import '../utils/res/app_snackbar.dart';
import '../widgets/task_details.dart';
import './task_text_widget.dart';
import './dismissed_widget.dart';
import './checkboxs/task_checkbox.dart';

const duration = Duration(seconds: 3);

/// [TaskTile] is a [ListTile] widget that is draggable. It displays the
/// properties of the task and can be manipulated to get the desired
/// customization offered by the [TaskTile] paramters.
class TaskTile extends StatelessWidget {
  /// This parameter is used fetch a task from the [Tasks] class.
  final String id;

  /// This handles the animation of the [TaskTile]
  final Animation<double> animation;

  /// This [onAddTaskFn] adds the task when it is removed by the [onRemoveFn]
  final Function(Task)? onAddTaskFn;

  /// This [onRemoveFn] deletes the task.
  final Function(Task)? onRemoveFn;

  /// This [onSwapItemRemoveFromUiFn] deletes the task from the [AnimatedList]
  ///  and it to another [AnimatedList].
  final Function(Task)? onSwapItemRemoveFromUiFn;

  /// This [onRemoveFromUI] deletes the task from the Screen.
  final Function(Task)? onRemoveFromUI;

  /// [onLongPress] is executed when the [TaskTile] is pressed for long.
  final Function(Task)? onLongPress;

  /// This [activityType] defines the type of [ActivityType] the task belongs
  /// to.
  final ActivityType activityType;

  /// Checks if the [TaskTile] is in selected mode to display the appropriate
  /// and corresponding widgets.
  final bool? isSelected;

  /// This is the color of the icons
  final Color color;

  /// This constructor initialized the parameters defined in the [TaskTile]
  /// class.
  const TaskTile({
    Key? key,
    required this.id,
    required this.animation,
    this.onRemoveFn,
    this.onAddTaskFn,
    this.activityType = ActivityType.non,
    this.onSwapItemRemoveFromUiFn,
    this.onLongPress,
    this.isSelected = false,
    required this.color,
    this.onRemoveFromUI,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Handles the display of scaffold in this context
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final tksProvider = context.read<Tasks>();
    final taskData = Provider.of<Tasks>(context).getTaskById(id);
    final remindMe =
        Provider.of<RemindMeList>(context, listen: false).getReminderById(id);

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
          color: isSelected!
              ? activityType == ActivityType.myDay
                  ? Colors.black
                  : Colors.white38
              : activityType == ActivityType.myDay
                  ? Colors.black54
                  : Colors.white30,
          child: Dismissible(
            key: UniqueKey(),
            dragStartBehavior: DragStartBehavior.start,
            secondaryBackground: DismissedWidget(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              color: Theme.of(context).colorScheme.error,
              icon: Icons.delete,
            ),
            background: DismissedWidget(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              color: Theme.of(context).colorScheme.secondary,
              icon: Icons.sunny,
            ),
            onDismissed: (direction) => onDismissed(
              context: context,
              direction: direction,
              scaffoldMessenger: scaffoldMessenger,
              task: taskData,
            ),
            child: SizedBox(
              height: 60,
              child: ListTile(
                onTap: isSelected!
                    ? () => tksProvider.toggleIsSelected(taskData.id)
                    : () {
                        Navigator.of(context).pushNamed(
                          TaskDetails.id,
                          arguments: {
                            'color': color,
                            'parent': 'Tasks',
                            'task': taskData,
                          },
                        );
                      },
                onLongPress: () => onLongPress!(taskData),
                selected: isSelected!,
                horizontalTitleGap: 0,
                leading: Transform.scale(
                  scale: 1.2,
                  child: isSelected!
                      ? TaskCheckbox(
                          color: color,
                          onChanged: (_) {
                            tksProvider.toggleIsSelected(taskData.id);
                          },
                          isRounded: false,
                          value: taskData.isSelected,
                        )
                      : TaskCheckbox(
                          color: color,
                          onChanged: (_) {
                            activityType != ActivityType.planned
                                ? onSwapItemRemoveFromUiFn!(taskData)
                                : null;
                            context.read<Tasks>().toggleIsDone(taskData.id);
                          },
                          value: taskData.isDone,
                        ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // This widget displays the title of the task
                    TaskTextWidget(
                      text: taskData.task,
                      color: Colors.white,
                      isDone: taskData.isDone,
                    ),
                    // The is if statement checks and adds the subtitle widgets
                    // for the appropriate screen
                    if (activityType == ActivityType.important ||
                        activityType == ActivityType.planned)
                      Row(
                        children: [
                          if (taskData.myDay)
                            _taskWidget(Icons.sunny, Colors.grey, 'My Day'),
                          const TaskTextWidget(
                              text: 'Tasks', color: Colors.grey),
                          if (remindMe != null && taskData.remindMe)
                            Row(
                              children: [
                                const SizedBox(width: 5),
                                _taskWidget(
                                    taskData.remindMe
                                        ? Icons.alarm
                                        : Icons.task_outlined,
                                    color,
                                    remindMe.title)
                              ],
                            )
                        ],
                      ),
                    if (activityType == ActivityType.non ||
                        activityType == ActivityType.myDay)
                      Row(
                        children: [
                          if (activityType == ActivityType.myDay)
                            const TaskTextWidget(
                                text: 'Tasks', color: Colors.grey),
                          if (activityType == ActivityType.non &&
                              taskData.myDay)
                            _taskWidget(Icons.sunny, Colors.grey, 'My Day'),
                          if (remindMe != null &&
                              (taskData.remindMe || taskData.addDueDate))
                            _taskWidget(
                                taskData.addDueDate && taskData.remindMe
                                    ? Icons.task_outlined
                                    : taskData.remindMe
                                        ? Icons.notifications_none
                                        : Icons.task_outlined,
                                color,
                                remindMe.title)
                        ],
                      ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: isSelected!
                      ? null
                      : () => toggleStar(context, scaffoldMessenger, taskData),
                  icon: Icon(
                    taskData.isStarred ? Icons.star : Icons.star_border,
                    color: taskData.isStarred ? color : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskWidget(IconData icon, Color color, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 5),
        TaskTextWidget(
          text: title,
          color: color,
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  void onDismissed({
    required BuildContext context,
    required DismissDirection direction,
    required ScaffoldMessengerState scaffoldMessenger,
    required Task task,
  }) {
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
      context.read<Tasks>().toggleMyDay(task.id);
      if (activityType == ActivityType.myDay) {
        onRemoveFromUI!(task);
      }
    }
  }

  void toggleStar(
    BuildContext context,
    ScaffoldMessengerState scaffoldMessenger,
    Task task,
  ) {
    final taskProvider = context.read<Tasks>();
    if (activityType == ActivityType.important) {
      onRemoveFromUI!(task);
    }
    taskProvider.toggleIsStarred(task.id);
    if (task.isStarred == true && activityType == ActivityType.important) {
      scaffoldMessenger.showSnackBar(
        snackbar(
          duration: duration,
          msg: 'Task removed from Importance',
          scaffoldMessenger: scaffoldMessenger,
          onPressed: () {
            taskProvider.starTask(task.id);
            onAddTaskFn!(task);
            scaffoldMessenger.hideCurrentSnackBar();
          },
        ),
      );
    }
  }
}
