import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/models/task.dart';
import 'package:to_do_clone/providers/task.dart';
import 'package:to_do_clone/widgets/task_tile.dart';

class Tasks extends StatefulWidget {
  final Color color;
  static const String id = '/tasks';

  const Tasks({super.key, required this.color});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  late TextEditingController addTaskController;
  late bool addTaskIcon;

  @override
  void initState() {
    super.initState();
    addTaskIcon = true;
    addTaskController = TextEditingController();

    addTaskController.addListener(() {
      if (addTaskController.value.text.isEmpty) {
        addTaskIcon = !addTaskIcon;
      }
    });
  }

  @override
  void dispose() {
    addTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<TaskList>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: widget.color),
        actionsIconTheme: IconThemeData(color: widget.color),
        title: Text(
          'Tasks',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: widget.color),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return TaskTile(
              id: index,
              color: widget.color,
              task: list.taskList[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 2);
          },
          itemCount: list.taskList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTask(context),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Widget taskSpecialButtons(
      {Function()? onTap, required IconData icon, required String label}) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white),
      ),
    );
  }

  Future<dynamic> addTask(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addTaskController,
                decoration: InputDecoration(
                  hintText: 'Add a task',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white12),
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.circle_outlined,
                      size: 32, color: Colors.white12),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      context.read<TaskList>().addToList(
                            Task(task: addTaskController.text),
                          );
                      addTaskController.clear();
                    },
                    child: Icon(
                        addTaskIcon
                            ? Icons.file_upload_outlined
                            : Icons.upgrade_outlined,
                        color: Colors.white,
                        size: 32),
                  ),
                ),
              ),
              Row(
                children: [
                  taskSpecialButtons(
                      icon: Icons.calendar_month_rounded,
                      label: 'Set due date'),
                  taskSpecialButtons(
                      icon: Icons.notifications_outlined, label: 'Remind me'),
                  taskSpecialButtons(icon: Icons.repeat, label: 'Repeat'),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
