// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

import '../../enums/activity_type.dart';
import '../../providers/my_day_tasks.dart';
import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';
import '../../widgets/buttons/special_button.dart';

class MyDayScreen extends StatefulWidget {
  static const String id = '/my_day';

  /// This retrieves the name and color of the parent [ActionWidget]
  final Map<String, dynamic> args;
  const MyDayScreen({super.key, required this.args});

  @override
  State<MyDayScreen> createState() => _MyDayScreenState();
}

class _MyDayScreenState extends State<MyDayScreen> {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<MyDayTasks>(context);
    return SizedBox(
      child: ActivityWidget(
        title: widget.args['activity'],
        color: widget.args['color'],
        displaySubtitle: true,
        subtitle: DateFormat.MMMMEEEEd().format(DateTime.now()),
        completedListModel:
            tasksProvider.doneTask,
        unDoneListModel:
            tasksProvider.undoneTasks,
        bgImage: 'assets/images/my_day.png',
        insert: (item, index) => context.read<Tasks>().insert(item, index),
        remove: (index) => context.read<Tasks>().removeTask(index),
        isExtended: true,
        activityType: ActivityType.myDay,
        specialButtons: const [
          SpecialButton(
            label: 'Tasks',
            icon: Icons.home_outlined,
          ),
          SpecialButton(
            label: 'Set due date',
            icon: Icons.calendar_month_rounded,
          ),
          SpecialButton(
            label: 'Remind me',
            icon: Icons.notifications_on_outlined,
          ),
          SpecialButton(
            label: 'Repeat',
            icon: Icons.repeat,
          ),
        ],
      ),
    );
  }
}
