import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/enums/activity_type.dart';

import '../enums/planned_menu_value.dart';
import '../models/animated_list_model.dart';
import '../models/task.dart';
import '../providers/add_due_date_list.dart';
import '../providers/planned_tasks.dart';
import '../providers/remind_me_list.dart';
import '../providers/tasks.dart';
import 'animated_list_widget.dart';
import 'animated_title.dart';
import 'app_bars/default_app_bar.dart';
import 'pop_up_menus/planned_pop_up_menu.dart';
import 'task_tile.dart';

class PlannedActivityWidget extends StatefulWidget {
  const PlannedActivityWidget({
    super.key,
    this.bgImage,
    required this.title,
    required this.color,
    required this.tasks,
    this.remove,
    this.insert,
  });

  final Function(Task, int?)? insert;
  final Function(Task)? remove;
  final String? bgImage;
  final Color color;
  final List<Task> tasks;
  final String title;

  @override
  State<PlannedActivityWidget> createState() => _PlannedActivityWidgetState();
}

class _PlannedActivityWidgetState extends State<PlannedActivityWidget> {
  //* This is a GlobalKey for handling the [AnimatedListState] of the
  //* undone tasks.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  //* Animated list of undone tasks
  late AnimatedListModel<Task> _listModel;

  //* this is the title of the [PlannedPopupMenu]
  var _plannedPopUpTitle = 'All planned';

  @override
  void didChangeDependencies() {
    _initListModel(Provider.of<PlannedTasks>(context).filteredTask);
    // _initListModel([]);
    super.didChangeDependencies();
  }

  void changePopupTitle(String value) {
    setState(() {
      _plannedPopUpTitle = value;
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

  /// Initializes [_listModel] with list of [Task]s.
  void _initListModel(List<Task> tasks) {
    _listModel = AnimatedListModel(
      listKey: _listKey,
      initialItems: tasks,
      removedItemBuilder: (_, __, ___) => Container(),
    );
  }

  /// [_insert] function handles the insertion of [Task]s to
  /// the [AnimatedList].
  void _insert(Task item, AnimatedListModel listModel, [int? cIndex]) {
    //* Insert [item ]to the [Tasks] provider using the [widget.insert()]
    //* function
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

  /// [_removeFromUI] function removes task from the current [AnimatedList]
  /// ([listModel]).
  void _removeFromUI(Task task, AnimatedListModel<Task> listModel) {
    final cIndex = listModel.indexWhere((element) => element.id == task.id);
    listModel.removeAt(cIndex);

    setState(() {});
  }

  void _toggleOnSelected(
    List<String> idList,
    PlannedMenuValue value,
    String poptitle,
  ) {
    idList.addAll([...context.read<RemindMeList>().filterItem(value)]);
    idList.addAll([...context.read<AddDueDateList>().filterItem(value)]);
    idList.toSet();
    _listModel.filterItem(
        context.read<PlannedTasks>().filterTask(idList), widget.tasks);
    changePopupTitle(poptitle);
  }

  void _onSelected(PlannedMenuValue value) {
    List<String> idList = [];

    switch (value) {
      case PlannedMenuValue.overDue:
        _toggleOnSelected(idList, value, 'Overdue');
        break;
      case PlannedMenuValue.today:
        _toggleOnSelected(idList, value, 'Today');
        break;
      case PlannedMenuValue.tomorrow:
        _toggleOnSelected(idList, value, 'Tomorrow');
        break;
      case PlannedMenuValue.thisWeek:
        _toggleOnSelected(idList, value, 'This week');
        break;
      case PlannedMenuValue.later:
        _toggleOnSelected(idList, value, 'Later');
        break;
      default:
        _toggleOnSelected(idList, value, 'All planned');
    }
  }

  /// Builds the undone [TaskTile].
  Widget _buildTaskTile(BuildContext context, int index,
      Animation<double> animation, AnimatedListModel<Task> listModel) {
    return TaskTile(
      id: listModel[index].id,
      animation: animation,
      color: widget.color,
      onAddTaskFn: (task) => _insert(task, listModel, index),
      onRemoveFn: (item) => _remove(item, index, listModel),
      onRemoveFromUI: (item) => _removeFromUI(item, listModel),
      activityType: ActivityType.planned,
    );
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
                    driveAnimation: !_listModel.isEmpty,
                    title: widget.title,
                    displaySubtitle: false,
                    titleColor: widget.color,
                  ),
                ),
                AnimatedListWidget(
                  listModel: _listModel,
                  color: widget.color,
                  itemBuilder: (ctx, index, animation) =>
                      _buildTaskTile(ctx, index, animation, _listModel),
                  displayHeaderWidget: false,
                  headerWidget: PlannedPopupMenu(
                    color: widget.color,
                    title: _plannedPopUpTitle,
                    onSelected: _onSelected,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
