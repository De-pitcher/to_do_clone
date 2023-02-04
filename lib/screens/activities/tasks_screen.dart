import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../models/list_model.dart';
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
  late final GlobalKey<AnimatedListState> _listKey;
  late ListModel<Task> _list;

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tasksProvider = Provider.of<Tasks>(context);
    _list = ListModel(
      listKey: _listKey,
      initialItems: tasksProvider.tasks,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  Widget _buildTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      TaskTile(
        task: _list[index],
        animation: animation,
      );

  Widget _buildRemovedItem(
    Task task,
    BuildContext context,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: task,
      animation: animation,
    );
  }

  void _insert(Task item) {
    final int index = _list.length;
    _list.insert(index, item);
    setState(() {});
  }

  void _removeAt(int index) {
    _list.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
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
            ? Center(
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.deepPurple,
                            ),
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _list.length,
                  itemBuilder: _buildTaskTile,
                ),
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
        return AddTaskBottomSheet(
          addTaskFn: _insert,
        );
      },
    );
  }
}
