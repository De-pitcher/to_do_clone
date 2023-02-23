import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../enums/activity_type.dart';
import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';
import '../../widgets/buttons/special_button.dart';

class MyDayScreen extends StatefulWidget {
  static const String id = '/my_day';
  const MyDayScreen({super.key});

  @override
  State<MyDayScreen> createState() => _MyDayScreenState();
}

class _MyDayScreenState extends State<MyDayScreen> {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return SizedBox(
      child: ActivityWidget(
        title: 'My Day',
        displaySubtitle: true,
        subtitle: DateFormat.MMMMEEEEd().format(DateTime.now()),
        completedListModel:
            tasksProvider.myDayTasks.where((tks) => tks.isDone).toList(),
        unDoneListModel:
            tasksProvider.myDayTasks.where((tks) => !tks.isDone).toList(),
        color: Colors.white,
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
