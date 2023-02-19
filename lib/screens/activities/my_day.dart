import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums/activity_type.dart';
import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';
import '../../widgets/buttons/special_button.dart';

class MyDay extends StatefulWidget {
  static const String id = '/my_day';
  const MyDay({super.key});

  @override
  State<MyDay> createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return SizedBox(
      // height: MediaQuery.of(context).size.height - 10,
      child: ActivityWidget(
        title: 'My Day',
        displaySubtitle: true,
        subtitle: 'Saturday, February 11',
        listModel: tasksProvider.myDayTasks,
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
