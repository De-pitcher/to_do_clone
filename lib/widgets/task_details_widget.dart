import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_steps.dart';
import '../providers/tasks.dart';
import './task_detail_option_widget.dart';
import 'pop_up_menus/add_due_date_pop_up_menu.dart';
import 'pop_up_menus/remind_me_pop_up_menu.dart';

class TaskDetailsWidget extends StatefulWidget {
  final Task task;
  final Color color;
  const TaskDetailsWidget({
    super.key,
    required this.task,
    required this.color,
  });

  @override
  State<TaskDetailsWidget> createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  late TextEditingController _stepsController;
  final FocusNode _addStepFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _stepsController = TextEditingController();
  }

  @override
  void dispose() {
    _addStepFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        //* _addStep.hasFocus displays a rounded rectangle if the addStep
        // textfield has focus otherwise it displays the add icon
        leading: _addStepFocus.hasFocus
            ? Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            : Icon(
                Icons.add,
                color: widget.color,
              ),
        onTap: () {
          FocusScope.of(context).requestFocus(_addStepFocus);
        },
        title: TextField(
          controller: _stepsController,
          focusNode: _addStepFocus,
          onTap: () {
            FocusScope.of(context).requestFocus(_addStepFocus);
          },
          onSubmitted: (value) {
            final atn = context.read<TaskSteps>();
            atn.addStep(value);
            _stepsController.clear();
          },
          decoration: InputDecoration(
            hintText: 'Add step',
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: widget.color),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
      TaskDetailsOptionWidget(
        title: 'Add to my Day',
        icon: CupertinoIcons.brightness,
        onTap: () => context.read<Tasks>().toggleMyDay(widget.task.id),
        isEnabled: widget.task.myDay,
        color: widget.color,
      ),
      RemindMePopupMenu(
        id: widget.task.id,
        isEnabled: widget.task.remindMe,
        color: widget.color,
      ),
      const Divider(
        thickness: 1.5,
        color: Colors.white30,
        indent: 70,
      ),
      // TaskDetailsOptionWidget(
      //   title: 'Add due time',
      //   icon: CupertinoIcons.calendar,
      //   isEnabled: false,
      //   color: widget.color,
      // ),
      AddDueDatePopupMenu(
        id: widget.task.id,
        isEnabled: widget.task.addDueDate,
        color: widget.color,
      ),
      const Divider(
        thickness: 1.5,
        color: Colors.white30,
        indent: 70,
      ),
      TaskDetailsOptionWidget(
        title: 'Repeat',
        icon: CupertinoIcons.repeat,
        isEnabled: false,
        color: widget.color,
      ),
      TaskDetailsOptionWidget(
        title: 'Add file',
        icon: Icons.file_open,
        isEnabled: false,
        color: widget.color,
      ),
      const SizedBox(height: 5),
      TextField(
        maxLines: 9,
        onTap: () {},
        decoration: const InputDecoration(
          filled: false,
          hintText: 'Add note',
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      )
    ]);
  }
}
