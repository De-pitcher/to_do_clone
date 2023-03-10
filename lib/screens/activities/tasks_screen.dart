import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';
import '../../widgets/buttons/special_button.dart';

class TasksScreen extends StatelessWidget {
  static const String id = '/tasks';

  /// This retrieves the name and color of the parent [ActionWidget]
  final Map<String, dynamic> args;
  
  /// [TasksScreen] is a screen that displays all the tasks created 
  /// in the app using the [ActivityWidget]. [ActivityWidget] can be used to 
  /// manipulate the tasks. New tasks can be created by clicking the
  /// [FloatingActionButton].
  const TasksScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ActivityWidget(
      title: args['activity'],
      displaySubtitle: false,
      unDoneListModel: Provider.of<Tasks>(context).unDoneTasks,
      completedListModel: Provider.of<Tasks>(context).isDoneTasks,
      color: args['color'],
      insert: (item, index) => context.read<Tasks>().insert(item, index),
      remove: (index) => context.read<Tasks>().removeTask(index),
      emptyWidget: _buildEmptyWidget(context),
      isExtended: false,
      fabIcon: const Icon(Icons.add, size: 32),
      specialButtons: const [
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
    );
  }

  Center _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          Image.asset(
            'assets/images/empty_image.png',
          ),
          SizedBox(
            width: 210,
            child: Text(
              'Tasks show up here if they aren\'t part of any'
              ' list you\'ve created.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.deepPurple,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
