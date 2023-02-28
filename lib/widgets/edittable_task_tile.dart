import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import 'checkboxs/task_checkbox.dart';

class EdittableTaskTile extends StatefulWidget {
  final String id;
  final String text;
  final bool isDone;
  final bool isStarred;
  final Color color;
  const EdittableTaskTile({
    super.key,
    required this.id,
    required this.text,
    required this.isDone,
    required this.isStarred,
    required this.color,
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
      text: widget.text,
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
                  context.read<Tasks>().toggleIsDone(widget.id);
                });
              },
              value: widget.isDone,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(
                decoration: widget.isDone
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
              widget.isStarred ? Icons.star : Icons.star_border,
              color: widget.isStarred ? widget.color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
