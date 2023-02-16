import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/animated_list_model.dart';
import '../../models/task.dart';
import '../../providers/tasks.dart';
import '../../widgets/animated_title.dart';
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
  var _liftTitle = false;

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<Tasks>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
        iconTheme: IconThemeData(color: widget.args['color']),
        actionsIconTheme: IconThemeData(color: widget.args['color']),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedTitle(
                driveAnimation: _liftTitle,
                title: 'Tracks',
                displaySubtitle: false,
                titleColor: widget.args['color'],
              ),
              tasksProvider.tasks.isEmpty
                  ? buildEmptyWidget(context)
                  : buildAnimatedList(tasksProvider.tasks.length)
            ],
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _listModel.length,
          itemBuilder: _buildTaskTile,
        ),
      ),
    );
  }

  Center buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (_liftTitle)
          //   SizedBox(height: MediaQuery.of(context).size.height * 0.25),
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
    setState(() {
      _liftTitle = true;
    });
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
