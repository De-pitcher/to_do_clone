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
    final plannedTksProvider = Provider.of<PlannedTasks>(context);
    return PlannedActivityWidget(
      title: widget.args['activity'],
      color: widget.args['color'],
      tasks: plannedTksProvider.tasks,
      popupTitle: plannedTksProvider.popupTitle,
      insert: (item, index) => context.read<Tasks>().insert(item, index),
      remove: (index) => context.read<Tasks>().removeTask(index),
    );
  }
}
