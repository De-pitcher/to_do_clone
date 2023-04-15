import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/activity_type.dart';
import '../providers/task_steps.dart';
import '../providers/tasks.dart';
import '../models/task.dart';
import './action_info.dart';
import './edittable_task_tile.dart';
import './task_details_widget.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  final String parent;
  final Color color;
  final ActivityType activityType;
  final Function(Task)? onRemoveFromUI;
  final Function(Task)? onSwapItemRemoveFromUiFn;
  const TaskDetails({
    super.key,
    required this.activityType,
    this.onRemoveFromUI,
    this.onSwapItemRemoveFromUiFn,
    required this.task,
    required this.parent,
    required this.color,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    final stepsList = Provider.of<TaskSteps>(context);

    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        elevation: 0,
        title: Text(widget.parent),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EdittableTaskTile(
              id: widget.task.id,
              initText: widget.task.task,
              color: widget.color,
              activityType: widget.activityType,
              onRemoveFromUI: widget.onRemoveFromUI,
              onSwapItemRemoveFromUiFn: widget.onSwapItemRemoveFromUiFn,
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: stepsList.steps.isEmpty
                    ? [
                        TaskDetailsWidget(
                          task: widget.task,
                          color: widget.color,
                        )
                      ]
                    : [
                        ...stepsList.steps,
                        ...[
                          TaskDetailsWidget(
                            task: widget.task,
                            color: widget.color,
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
