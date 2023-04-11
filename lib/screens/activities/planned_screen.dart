import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/planned_tasks.dart';
import '../../providers/tasks.dart';
import '../../widgets/planned_activity_widget.dart';

class PlannedScreen extends StatefulWidget {
  static const String id = '/planned';

  /// This retrieves the name and color of the parent [ActionWidget]
  final Map<String, dynamic> args;
  const PlannedScreen({super.key, required this.args});

  @override
  State<PlannedScreen> createState() => _PlannedScreenState();
}

class _PlannedScreenState extends State<PlannedScreen> {
  @override
  Widget build(BuildContext context) {
    return PlannedActivityWidget(
      title: widget.args['activity'],
      color: widget.args['color'],
      tasks: Provider.of<PlannedTasks>(context).tasks,
      remove: (index) => context.read<Tasks>().removeTask(index),

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
