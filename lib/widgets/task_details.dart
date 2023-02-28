import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_steps.dart';
import '../providers/tasks.dart';
import '../models/task.dart';
import './action_info.dart';
import './edittable_task_tile.dart';
import './task_details_widget.dart';

class TaskDetails extends StatefulWidget {
  static const String id = '/task_detail';

  final Map<String, dynamic> args;
  const TaskDetails({super.key, required this.args});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final stepsList = Provider.of<TaskSteps>(context);
    final cTask = Provider.of<Tasks>(context)
        .tasks
        .firstWhere((e) => e.id == (widget.args['task'] as Task).id);
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        title: Text('${widget.args['parent']}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EdittableTaskTile(
              id: cTask.id,
              text: cTask.task,
              isDone: cTask.isDone,
              isStarred: cTask.isStarred,
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: stepsList.steps.isEmpty
                    ? [
                        TaskDetailsWidget(
                          task: cTask,
                          color: widget.args['color'],
                        )
                      ]
                    : [
                        ...stepsList.steps,
                        ...[
                          TaskDetailsWidget(
                            task: cTask,
                            color: widget.args['color'],
                          )
                        ]
                      ],
              ),
            ),
            const ActionInfo()
          ],
        ),
      ),
    );
  }
}
