import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/enums/activity_type.dart';

import '../enums/planned_menu_value.dart';
import '../models/animated_list_model.dart';
import '../models/task.dart';
import '../providers/tasks.dart';
import '../utils/constants/pop_menu_items.dart';
import 'animated_list_widget.dart';
import 'animated_title.dart';
import 'app_bars/default_app_bar.dart';
import 'pop_up_menus/planned_pop_up_menu.dart';
import 'task_tile.dart';

class PlannedActivityWidget extends StatefulWidget {
  final String? bgImage;
  final String title;
  final Color color;
  final List<Task> tasks;
  final Function(Task)? remove;
  const PlannedActivityWidget({
    super.key,
    this.bgImage,
    required this.title,
    required this.color,
    required this.tasks,
    this.remove,
  });

  @override
  State<PlannedActivityWidget> createState() => _PlannedActivityWidgetState();
}

class _PlannedActivityWidgetState extends State<PlannedActivityWidget> {
  //* This is a GlobalKey for handling the [AnimatedListState] of the
  //* undone tasks.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  //* Animated list of undone tasks
  late AnimatedListModel<Task> _listModel;
  //* Animated the title of the activity screen when set to true
  var _liftTitle = false;
  //* Handles the animated of the [CompletedTaskHeader].
  var _isExpanded = true;
  //*
  var _isSelected = false;
  //* this is the title of the [PlannedPopupMenu]
  var _plannedPopUpTitle = 'All planned';

  @override
  void didChangeDependencies() {
    //* Initialized the undone and the completed list of tasks.
    _listModel = AnimatedListModel(
      listKey: _listKey,
      initialItems: widget.tasks,
      removedItemBuilder: (_, __, ___) => Container(),
    );

    super.didChangeDependencies();
  }

  void changePopupTitle(String value) {
    setState(() {
      _plannedPopUpTitle = value;
    });
  }

  void _onSelected(PlannedMenuValue value) {
    switch (value) {
      case PlannedMenuValue.overDue:
        changePopupTitle('Overdue');
        break;
      case PlannedMenuValue.today:
        changePopupTitle('Today');
        break;
      case PlannedMenuValue.tomorrow:
        changePopupTitle('Tomorrow');
        break;
      case PlannedMenuValue.thisWeek:
        changePopupTitle('This week');
        break;
      case PlannedMenuValue.later:
        changePopupTitle('Later');
        break;
      default:
        changePopupTitle('All planned');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, widget.color),
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
                    displaySubtitle: false,
                    titleColor: widget.color,
                  ),
                ),
                AnimatedListWidget(
                  listModel: _listModel,
                  color: widget.color,
                  itemBuilder: _buildTaskTile,
                  // onHide: _onHide,
                  displayHeaderWidget: false,
                  headerWidget: PlannedPopupMenu(
                    color: widget.color,
                    title: _plannedPopUpTitle,
                    onSelected: _onSelected,
                  ),

                  // isExpanded: _isExpanded,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// [_insert] function handles the insertion of [Task]s to
  /// the [AnimatedList].
  void _insert(Task item, AnimatedListModel listModel, [int? cIndex]) {
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

  /// [_swapItemFromUI] function removes task from the current [AnimatedList]
  /// ([listModel]) and adds it to the next [AnimatedList] ([nextListModel]).
  void _swapItemFromUI(Task task, AnimatedListModel<Task> listModel,
      AnimatedListModel<Task> nextListModel) {
    final cIndex = listModel.indexWhere((element) => element.id == task.id);
    final item = listModel.removeAt(cIndex);

    final index =
        cIndex >= nextListModel.length ? nextListModel.length : cIndex;
    nextListModel.insert(index, item);

    setState(() {});
  }

  /// [_removeFromUI] function removes task from the current [AnimatedList]
  /// ([listModel]).
  void _removeFromUI(Task task, AnimatedListModel<Task> listModel) {
    final cIndex = listModel.indexWhere((element) => element.id == task.id);
    listModel.removeAt(cIndex);

    setState(() {});
  }

  /// [_removeSelectedItemsFromUi] function removes task from the current [AnimatedList]
  /// ([listModel]) and adds it to the next [AnimatedList] ([nextListModel]).
  void _removeSelectedItemsFromUi(
    AnimatedListModel<Task> listModel,
    AnimatedListModel<Task> nextListModel,
    List<Task> tasks,
  ) {
    setState(() {
      removeAnimatedItems(listModel, [...tasks.where((tks) => !tks.isDone)]);
      removeAnimatedItems(nextListModel, [...tasks.where((tks) => tks.isDone)]);
    });
  }

  /// [removeAnimatedItems] reomves selected items.
  void removeAnimatedItems(
      AnimatedListModel<Task> listModel, List<Task> tasks) {
    for (var item in tasks) {
      final index = listModel.indexWhere((element) => element.id == item.id);
      listModel.removeAt(index);
      context.read<Tasks>().removeTask(item);
    }
  }

  /// Builds the undone [TaskTile].
  Widget _buildTaskTile(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return TaskTile(
      id: _listModel[index].id,
      animation: animation,
      color: widget.color,
      // onAddTaskFn: (task) => _insert(task, _listModel, index),
      // onRemoveFn: (item) => _remove(item, index, _listModel),
      // onRemoveFromUiFn: () =>
      // _removeFromUi(index, _listModel, _completedListModel),
      onRemoveFn: (item) => _remove(item, index, _listModel),
      // onSwapItemRemoveFromUiFn: (item) =>
      //     _swapItemFromUI(item, _listModel, _completedListModel),
      onRemoveFromUI: (item) => _removeFromUI(item, _listModel),
      activityType: ActivityType.planned,
      // plannedMenuValue: ,
      // isSelected: _isSelected,
      // onLongPress: onLongPressed,
    );
  }
}
