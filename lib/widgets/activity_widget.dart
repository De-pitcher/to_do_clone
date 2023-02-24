import 'package:flutter/material.dart';

import './completed_task_header.dart';
import './task_tile.dart';
import '../enums/activity_type.dart';
import '../models/animated_list_model.dart';
import '../models/task.dart';
import './animated_title.dart';
import './bottom_sheet/add_task_bottom_sheet.dart';
import './buttons/special_button.dart';

class ActivityWidget extends StatefulWidget {
  /// This is the title of the [ActivityWidget].
  final String title;

  /// This is the subtitle of the [ActivityWidget] which can
  /// be null.
  final String? subtitle;

  /// [bgImage] is the background image of the activity screen.
  final String? bgImage;

  /// Checks if [subtitle] should be displayed.
  final bool displaySubtitle;

  /// List of taks that is yet to be comleted.
  final List<Task> unDoneListModel;

  /// List of tasks that is completed
  final List<Task>? completedListModel;

  /// This is the color of the icons in the activity screen.
  final Color color;

  /// This widget can  be set to be displayed when there is no task
  /// on the activity screen but can be null.
  final Widget? emptyWidget;

  /// This function recieves two parameter: [Task] and then [int]
  /// which can be null. It is used to handle the insertion of a
  /// task either the first time on reinserting it when deleted.
  final Function(Task, int?)? insert;

  /// This function recieves only one parameter [Task]. It is
  /// used to handle the deletion of tasks.
  final Function(Task)? remove;

  /// This is of type [FloatingActionButtonLocation] and handles
  /// the position of the [FloatingActionButton]s.
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? fabIcon;

  /// This param [isExtended] to check if two [FloatingActionButton]
  /// should be displayed or not.
  final bool isExtended;

  /// [specialButtons] is used to define the list of [SpecialButton].
  final List<SpecialButton> specialButtons;

  /// This enum [activityType] defines the type of activity screen
  /// to be created.
  final ActivityType activityType;

  /// [ActivityWidget] is a widget that is used to create different
  /// activities that tasks can be grouped in.
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
  //* This is a GlobalKey for handling the [AnimatedListState] of the
  //* undone tasks.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  //* This is a GlobalKey for handling the [AnimatedListState] of the
  //* completed tasks.
  final GlobalKey<AnimatedListState> _completedListKey =
      GlobalKey<AnimatedListState>();
  //* Animated list of undone tasks
  late AnimatedListModel<Task> _listModel;
  //* Animated list of completed tasks.
  late AnimatedListModel<Task> _completedListModel;
  //* Animated the title of the activity screen when set to true
  var _liftTitle = false;
  //* Handles the animated of the [CompletedTaskHeader].
  var _isExpanded = true;

  @override
  void didChangeDependencies() {
    //* Initialized the undone and the completed list of tasks.
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

  /// [_insert] function handles the insertion of [Task]s both to the
  /// [AnimatedList] and to the [Task] provider. 
  void _insert(Task item, AnimatedListModel listModel, [int? cIndex]) {
    //* Inserts to the [Tasks] provider
    widget.insert!(item, cIndex);
    //* Inserts to the [AnimatedList].
    listModel.insert(cIndex ?? listModel.length, item);
  }

  /// [_remove] function handles the insertion of [Task]s both to the
  /// [AnimatedList] and to the [Task] provider.
  void _remove(Task item, int index, AnimatedListModel<Task> listModel) {
    //* Removes task from the [Tasks] provider. 
    widget.remove!(item);
    //* Removes task from the [AnimatedList].
    listModel.removeAt(index);
    setState(() {});
  }
  /// [_removeFromUi] function removes task from the current [AnimatedList] 
  /// ([listModel]) and adds it to the next [AnimatedList] ([nextListModel]).
  void _removeFromUi(int cIndex, AnimatedListModel<Task> listModel,
      AnimatedListModel<Task> nextListModel) {
    final item = listModel.removeAt(cIndex);
    final index =
        cIndex >= nextListModel.length ? nextListModel.length : cIndex;
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
                  _buildCompletedAnimatedList()
                else
                  Expanded(
                    child: Column(
                      children: [
                        _buildAnimatedList(),
                        _buildCompletedAnimatedList()
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

  /// Builds the undone [TaskTile].
  Widget _buildTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: widget.unDoneListModel[index],
      animation: animation,
      onAddTaskFn: (task) => _insert(task, _listModel, index),
      onRemoveFn: (item) => _remove(item, index, _listModel),
      onRemoveFromUiFn: () =>
          _removeFromUi(index, _listModel, _completedListModel),
      activityType: widget.activityType,
    );
  }

  /// Builds the completed [TaskTile].
  Widget _buildCompletedTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      task: widget.completedListModel![index],
      animation: animation,
      onAddTaskFn: (task) => _insert(task, _completedListModel, null),
      onRemoveFn: (item) => _remove(item, index, _completedListModel),
      onRemoveFromUiFn: () =>
          _removeFromUi(index, _completedListModel, _listModel),
      activityType: widget.activityType,
    );
  }

  /// Builds the task that is animated. In this case it is not needed
  /// so an empty [Container] is build instead.
  Widget _removedItemBuilder(
    Task task,
    BuildContext context,
    Animation<double> animation,
  ) {
    return Container();
  }

  /// [_buildAnimatedList] builds [AnimatedList] of undone [Task]s.
  Padding _buildAnimatedList() {
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

  /// [_buildCompletedAnimatedList] builds [AnimatedList] of undone [Task]s.
  Widget _buildCompletedAnimatedList() {
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
