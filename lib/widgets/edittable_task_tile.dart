import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/activity_type.dart';
import '../models/task.dart';
import '../providers/tasks.dart';
import 'checkboxs/task_checkbox.dart';

class EdittableTaskTile extends StatefulWidget {
  final String id;
  final String initText;
  final ActivityType activityType;
  final Function(Task)? onRemoveFromUI;
  final Function(Task)? onSwapItemRemoveFromUiFn;
  final Color color;
  const EdittableTaskTile({
    super.key,
    required this.color,
    required this.id,
    required this.activityType,
    this.onRemoveFromUI,
    this.onSwapItemRemoveFromUiFn, required this.initText,
  });

  @override
  State<EdittableTaskTile> createState() => _EdittableTaskTileState();
}

class _EdittableTaskTileState extends State<EdittableTaskTile> {
  late TextEditingController _controller;
  final FocusNode _addStepFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initText,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _addStepFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Tasks>(context).getTaskById(widget.id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: TaskCheckbox(
              color: widget.color,
              onChanged: (_) {
                setState(() {
                  if (widget.activityType == ActivityType.important) {
                    widget.onSwapItemRemoveFromUiFn!(task);
                  }
                  context.read<Tasks>().toggleIsDone(widget.id);
                });
              },
              value: task.isDone,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                decoration: task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText: 'Rename Task',
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white12),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                context.read<Tasks>().renameTask(widget.id, value);
              },
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<Tasks>().toggleIsStarred(widget.id);
            },
            icon: Icon(
              task.isStarred ? Icons.star : Icons.star_border,
              color: task.isStarred ? widget.color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
