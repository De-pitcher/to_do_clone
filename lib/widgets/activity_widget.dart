import 'package:flutter/material.dart';
import 'task_tile.dart';

import '../enums/activity_type.dart';
import '../models/animated_list_model.dart';
import '../models/task.dart';
import 'animated_title.dart';
import 'bottom_sheet/add_task_bottom_sheet.dart';

class ActivityWidget extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? bgImage;
  final bool displaySubtitle;
  final List<Task> listModel;
  final Color color;
  final Widget? emptyWidget;
  final Function(Task, int?)? insert;
  final Function(int)? remove;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? fabIcon;
  final Widget? bottomSheet;
  final bool isExtended;
  final List<Widget> specialButtons;
  final ActivityType activityType;
  const ActivityWidget({
    super.key,
    required this.listModel,
    required this.color,
    this.emptyWidget,
    this.insert,
    this.remove,
    required this.title,
    required this.displaySubtitle,
    this.subtitle,
    this.floatingActionButtonLocation,
    this.fabIcon,
    this.bottomSheet,
    required this.isExtended,
    this.bgImage,
    required this.specialButtons,
    this.activityType = ActivityType.non,
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
      backgroundColor: Colors.white24,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
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
      body: Container(
        width: double.infinity,
        decoration: widget.bgImage != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.bgImage!),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: AnimatedTitle(
                    driveAnimation: _liftTitle,
                    title: widget.title,
                    displaySubtitle: widget.displaySubtitle,
                    titleColor: widget.color,
                    subtitle: widget.subtitle,
                  ),
                ),
                widget.listModel.isEmpty
                    ? widget.emptyWidget ?? const Text('')
                    : buildAnimatedList(widget.listModel.length)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.isExtended
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    heroTag: UniqueKey(),
                    elevation: 5,
                    onPressed: () {},
                    label: Row(
                      children: const [
                        Icon(Icons.lightbulb_outline_sharp),
                        SizedBox(width: 10),
                        Text('Suggestion'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  FloatingActionButton(
                    heroTag: UniqueKey(),
                    elevation: 5,
                    onPressed: () => addTask(context),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          : FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: () => addTask(context),
              backgroundColor: widget.color,
              foregroundColor: Colors.black,
              child: widget.fabIcon,
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
      activityType: widget.activityType,
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
        height: MediaQuery.of(context).size.height * 0.8,
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
          specialButtons: widget.specialButtons,
          activityType: widget.activityType,
        );
      },
    );
  }
}
