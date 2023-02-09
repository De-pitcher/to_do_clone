import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  AnimatedListState? get _animatedList => _listKey.currentState;

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
            ? buildEmptyWidget(context)
            : buildAnimatedList(tasksProvider.length),
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
    final tskMdlProvider = Provider.of<Tasks>(context, listen: false);

    return TaskTile(
      task: tskMdlProvider.tasks[index],
      animation: animation,
      buildRemovedItem: _buildRemovedItem,
    );
  }

  Widget _buildRemovedItem(
    Task task,
    BuildContext context,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: task,
      animation: animation,
      buildRemovedItem: _buildRemovedItem,
    );
  }

  void _insert(Task item, [int? index]) {
    Provider.of<Tasks>(context, listen: false)
        .insertAt(item, _animatedList, index);
    setState(() {});
  }

  Padding buildAnimatedList(int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedList(
        key: _listKey,
        initialItemCount: itemCount,
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
          addTaskFn: (task) => _insert(task),
        );
      },
    );
  }
}
