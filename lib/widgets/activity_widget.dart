import 'package:flutter/material.dart';
import 'completed_task_header.dart';
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
  final List<Task> unDoneListModel;
  final List<Task>? completedListModel;
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

  /// [ActivityWidget] is a widget that is used to create different
  /// activities that tasks can be grouped in
  const ActivityWidget({
    super.key,
    required this.unDoneListModel,
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
    this.completedListModel = const <Task>[],
  });

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _completedListKey =
      GlobalKey<AnimatedListState>();
  late AnimatedListModel<Task> _listModel;
  late AnimatedListModel<Task> _completedListModel;
  var _liftTitle = false;
  var _isExpanded = true;

  @override
  void didChangeDependencies() {
    _listModel = AnimatedListModel(
      listKey: _listKey,
      initialItems: widget.unDoneListModel,
      removedItemBuilder: _removedItemBuilder,
    );
    _completedListModel = AnimatedListModel(
      listKey: _completedListKey,
      initialItems: widget.completedListModel,
      removedItemBuilder: _removedItemBuilder,
    );
    super.didChangeDependencies();
  }

  void _insert(Task item, AnimatedListModel listModel, [int? cIndex]) {
    final index = cIndex ?? listModel.length;
    widget.insert!(item, index);
    listModel.insert(index, item);
  }

  // void _insertToUi(Task item, AnimatedListModel listModel, [int? cIndex]) {
  //   final index = cIndex ?? listModel.length;
  //   widget.insert!(item, index);
  //   _listModel.insert(index, item);
  // }

  void _remove(int index, AnimatedListModel<Task> listModel,
      AnimatedListModel<Task> nextListModel) {
    widget.remove!(index);
    _removeFromUi(index, listModel, nextListModel);
  }

  void _removeFromUi(int cIndex, AnimatedListModel<Task> listModel,
      AnimatedListModel<Task> nextListModel) {
    final item = listModel.removeAt(cIndex);

    final index = cIndex > nextListModel.length ? nextListModel.length : cIndex;
    nextListModel.insert(index, item);
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
                if (widget.unDoneListModel.isEmpty &&
                    widget.completedListModel!.isEmpty)
                  widget.emptyWidget ?? const Text('')
                else if (widget.unDoneListModel.isEmpty &&
                    widget.completedListModel!.isNotEmpty)
                  buildCompletedAnimatedList()
                else
                  Expanded(
                    child: Column(
                      children: [
                        buildAnimatedList(),
                        buildCompletedAnimatedList()
                      ],
                    ),
                  )
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
      task: widget.unDoneListModel[index],
      animation: animation,
      onAddTaskFn: (task) => _insert(task, _listModel, index),
      onRemoveFn: () => _remove(
        index,
        _listModel,
        _completedListModel,
      ),
      onRemoveFromUiFn: () =>
          _removeFromUi(index, _listModel, _completedListModel),
      activityType: widget.activityType,
    );
  }

  Widget _buildCompletedTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: widget.completedListModel![index],
      animation: animation,
      onAddTaskFn: (task) => _insert(task, _completedListModel, index),
      onRemoveFn: () => _remove(index, _completedListModel, _listModel),
      onRemoveFromUiFn: () =>
          _removeFromUi(index, _completedListModel, _listModel),
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

  Padding buildAnimatedList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: _listModel.length * 70,
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _listModel.length,
          itemBuilder: _buildTaskTile,
        ),
      ),
    );
  }

  Widget buildCompletedAnimatedList() {
    return _completedListModel.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CompletedTaskHeader(
                  numCompleted: _completedListModel.length,
                  color: widget.color,
                  onHide: (value) {
                    setState(() {
                      _isExpanded = value;
                    });
                  },
                ),
                if (_isExpanded)
                  AnimatedOpacity(
                    opacity: _isExpanded ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: _completedListModel.length * 70,
                      child: AnimatedList(
                        key: _completedListKey,
                        initialItemCount: _completedListModel.length,
                        itemBuilder: _buildCompletedTaskTile,
                      ),
                    ),
                  ),
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
          addTaskFn: (item) => _insert(item, _listModel),
          specialButtons: widget.specialButtons,
          activityType: widget.activityType,
        );
      },
    );
  }
}
