import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/models/task_details_steps.dart';
import 'package:to_do_clone/widgets/step_tile.dart';

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

  Widget taskDetailsOptions(BuildContext context,
      {Function()? onTap, required IconData icon, required String option}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white38,
      ),
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

  Widget actionInfo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
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
    _controller = TextEditingController(text: '');
    _stepsController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stepsList = Provider.of<TaskDetailsSteps>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args['parent']}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.circle_outlined
                      // taskState.task.isDone ? Icons.circle : Icons.circle_outlined,
                      // color: color,
                      ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Rename Task',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white12),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                ),
              ],
            ),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: body(context),
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
        leading: const Icon(Icons.add),
        title: TextField(
          controller: _stepsController,
          onSubmitted: (value) {
            final atn = context.read<TaskDetailsSteps>();
            atn.addStep(value);
            _stepsController.clear();
  
          },
          decoration: InputDecoration(
            hintText: 'Add step',
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.purple),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
      taskDetailsOptions(context,
          icon: CupertinoIcons.brightness,
          option: 'Add to my Day',
          onTap: () {}),
      taskDetailsOptions(context,
          icon: Icons.notifications_outlined,
          option: 'Remind me',
          onTap: () {}),
      const Divider(thickness: 1.5, color: Colors.white30, indent: 70),
      taskDetailsOptions(context,
          icon: CupertinoIcons.calendar, option: 'Add due time', onTap: () {}),
      const Divider(thickness: 1.5, color: Colors.white30, indent: 70),
      taskDetailsOptions(context,
          icon: CupertinoIcons.repeat, option: 'Repeat', onTap: () {}),
      taskDetailsOptions(context,
          icon: Icons.file_open, option: 'Add file', onTap: () {}),
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
