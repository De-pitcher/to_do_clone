import 'package:flutter/material.dart';
import 'package:to_do_clone/widgets/task_tile.dart';

import '../models/animated_list_model.dart';
import '../models/task.dart';
import './animated_title.dart';
import './bottom_sheet/add_task_bottom_sheet.dart';

class ActivityWidget extends StatefulWidget {
  final List<Task> listModel;
  final Color color;
  final Widget emptyWidget;
  final Function(Task, int?)? insert;
  final Function(int)? remove;
  const ActivityWidget({
    super.key,
    required this.listModel,
    required this.color,
    required this.emptyWidget,
    this.insert,
    this.remove,
  });

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AnimatedListModel<Task> _listModel;
  var _liftTitle = false;

  @override
  void didChangeDependencies() {
    _listModel = AnimatedListModel(
      listKey: _listKey,
      initialItems: widget.listModel,
      removedItemBuilder: _removedItemBuilder,
    );
    super.didChangeDependencies();
  }

  void _insert(Task item, [int? cIndex]) {
    final index = cIndex ?? _listModel.length;
    widget.insert!(item, index);
    _listModel.insert(index, item);
  }

  void _remove(int index) {
    widget.remove!(index);
    _listModel.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        iconTheme: IconThemeData(color: widget.color),
        actionsIconTheme: IconThemeData(color: widget.color),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: AnimatedTitle(
                driveAnimation: _liftTitle,
                title: 'Tracks',
                displaySubtitle: false,
                titleColor: widget.color,
              ),
            ),
            widget.listModel.isEmpty
                ? widget.emptyWidget
                : buildAnimatedList(widget.listModel.length)
          ],
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

  Widget _buildTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: widget.listModel[index],
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
