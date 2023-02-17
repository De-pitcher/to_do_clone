import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_steps.dart';
import '../providers/tasks.dart';

class TaskDetails extends StatefulWidget {
  static const String id = '/task_detail';

  final Map<String, dynamic> args;
  const TaskDetails({super.key, required this.args});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _controller;
  late TextEditingController _stepsController;
  final FocusNode _addStepFocus = FocusNode();

  Widget actionInfo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: [
          const Divider(color: Colors.white30, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created on ',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white38),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white38,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.args["taskValue"],
    );
    _stepsController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _addStepFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stepsList = Provider.of<TaskSteps>(context);
    final cTask = Provider.of<Tasks>(context)
        .tasks
        .firstWhere((tks) => tks.id == widget.args['id']);
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
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: cTask.isDone,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    splashRadius: 35,
                    onChanged: (_) {
                      setState(() {
                        context.read<Tasks>().toggleIsDone(widget.args['id']);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      decoration: cTask.isDone
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
                      context.read<Tasks>().renameTask(cTask.id, value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<Tasks>().toggleIsStarred(widget.args['id']);
                  },
                  icon: Icon(
                    cTask.isStarred ? Icons.star : Icons.star_border,
                    color: cTask.isStarred ? Colors.deepPurple : Colors.grey,
                  ),
                ),
              ],
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: stepsList.steps.isEmpty
                    ? body(context)
                    : [...stepsList.steps, ...body(context)],
              ),
            ),
            actionInfo(context)
          ],
        ),
      ),
    );
  }

  List<Widget> body(BuildContext context) {
    return [
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
            : const Icon(
                Icons.add,
                color: Colors.deepPurple,
              ),
        onTap: () {
          FocusScope.of(context).requestFocus(_addStepFocus);
        },
        title: TextField(
          controller: _stepsController,
          focusNode: _addStepFocus,
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
                .copyWith(color: Colors.deepPurple),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
      const TaskDetailsOptionWidget(
        option: 'Add to my Day',
        icon: CupertinoIcons.brightness,
      ),
      const TaskDetailsOptionWidget(
        option: 'Remind me',
        icon: Icons.notifications_outlined,
      ),
      const Divider(
        thickness: 1.5,
        color: Colors.white30,
        indent: 70,
      ),
      const TaskDetailsOptionWidget(
        option: 'Add due time',
        icon: CupertinoIcons.calendar,
      ),
      const Divider(
        thickness: 1.5,
        color: Colors.white30,
        indent: 70,
      ),
      const TaskDetailsOptionWidget(
        option: 'Repeat',
        icon: CupertinoIcons.repeat,
      ),
      const TaskDetailsOptionWidget(
        option: 'Add file',
        icon: Icons.file_open,
      ),
      const SizedBox(height: 5),
      TextField(
        maxLines: 9,
        onTap: () {},
        decoration: const InputDecoration(
          filled: true,
          hintText: 'Add note',
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      )
    ];
  }
}

class TaskDetailsOptionWidget extends StatelessWidget {
  final String option;
  final IconData icon;
  final Function()? onTap;
  const TaskDetailsOptionWidget({
    super.key,
    required this.option,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white38),
      title: Text(
        option,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white38),
      ),
      onTap: onTap,
    );
  }
}
