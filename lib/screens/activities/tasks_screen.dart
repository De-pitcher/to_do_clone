import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/tasks.dart';
import '../../widgets/activity_widget.dart';

class TasksScreen extends StatelessWidget {
  final Map<String, dynamic> args;
  static const String id = '/tasks';

  const TasksScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return ActivityWidget(
      listModel: tasksProvider.tasks,
      color: args['color'],
      insert: (item, index) => context.read<Tasks>().insert(item, index),
      remove: (index) => context.read<Tasks>().removeTask(index),
      emptyWidget: _buildEmptyWidget(context),
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
