import 'package:flutter/material.dart';

import '../../models/task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Function(Task)? addTaskFn;
  final List<Widget> specialButtons;
  const AddTaskBottomSheet({
    required this.addTaskFn,
    super.key,
    required this.specialButtons,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _controller = TextEditingController();
  var _isFieldEmpty = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_controller.text.isNotEmpty) {
      Task newTask = Task(
        id: DateTime.now(),
        task: _controller.text,
        step: [],
      );
      widget.addTaskFn!(newTask);
      _controller.clear();
      setState(() {
        _isFieldEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            cursorColor: Colors.white,
            cursorHeight: 24,
            decoration: InputDecoration(
              hintText: 'Add a task',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white38),
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: const Icon(Icons.circle_outlined,
                  size: 32, color: Colors.white12),
              suffixIcon: GestureDetector(
                onTap: onSubmit,
                child: Icon(
                  Icons.file_upload_outlined,
                  color: _isFieldEmpty ? Colors.white38 : Colors.white60,
                  size: 32,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _isFieldEmpty = false;
                });
              } else {
                setState(() {
                  _isFieldEmpty = true;
                });
              }
            },
            onEditingComplete: onSubmit,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.specialButtons,
            ),
          )
        ],
      ),
    );
  }
}
