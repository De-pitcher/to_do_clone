import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../models/task.dart';
import '../../providers/tasks.dart';
import '../../widgets/task_tile.dart';
import '../../widgets/bottom_sheet/add_task_bottom_sheet.dart';

class TasksScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  static const String id = '/tasks';

  const TasksScreen({super.key, required this.args});

  @override
  State<TasksScreen> createState() => _TasksTasksScreenState();
}

class _TasksTasksScreenState extends State<TasksScreen> {
  late TextEditingController addTaskController;
  late bool addTaskIcon;

  @override
  void initState() {
    super.initState();
    addTaskIcon = false;
    addTaskController = TextEditingController();
  }

  @override
  void dispose() {
    addTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: widget.args['color']),
        actionsIconTheme: IconThemeData(color: widget.args['color']),
        title: Text(
          'Tasks',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: widget.args['color']),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: tasksProvider.tasks.isEmpty
            ? Container(
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/empty_image.png'),
                //     fit: BoxFit.fitHeight,
                //   ),
                // ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty_image.png',
                      ),
                      SizedBox(
                        width: 210,
                        child: Text(
                          'Tasks show up here if they aren\'t part of any list you\'ve created.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.deepPurple,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                itemBuilder: (context, index) {
                  return TaskTile(
                    // parent: widget.args['parent'],
                    // color: widget.args['color'],
                    task: tasksProvider.tasks[index],
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 4,
                ),
                itemCount: tasksProvider.tasks.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTask(context),
        backgroundColor: widget.args['color'],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Future<dynamic> addTask(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return const AddTaskBottomSheet();
      },
    );
  }
}
