import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/animated_list_model.dart';
import '../../models/task.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimatedListModel<Task> _listModel;

  @override
  void didChangeDependencies() {
    _listModel = AnimatedListModel(
      listKey: _listKey,
      initialItems: Provider.of<Tasks>(context, listen: false).tasks,
      removedItemBuilder: _removedItemBuilder,
    );
    super.didChangeDependencies();
  }

  void _insert(Task item, [int? cIndex]) {
    final index = cIndex ?? _listModel.length;
    context.read<Tasks>().insert(item, index);
    _listModel.insert(index, item);
  }

  void _remove(int index) {
    context.read<Tasks>().removeTask(index);
    _listModel.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
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
            ? buildEmptyWidget(context)
            : buildAnimatedList(tasksProvider.tasks.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTask(context),
        backgroundColor: widget.args['color'],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

  Widget _buildTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: _listModel[index],
      animation: animation,
      onAddTaskFn: (task) => _insert(task, index),
      onRemoveFn: () => _remove(index),
    );
  }

  Widget _removedItemBuilder(
    Task task,
    BuildContext context,
    Animation<double> animation,
  ) {
    return Container();
  }

  Padding buildAnimatedList(int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedList(
        key: _listKey,
        initialItemCount: _listModel.length,
        itemBuilder: _buildTaskTile,
      ),
    );
  }

  Center buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_image.png',
          ),
          SizedBox(
            width: 210,
            child: Text(
              'Tasks show up here if they aren\'t part of any'
              ' list you\'ve created.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.deepPurple,
                  ),
            ),
          )
        ],
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
