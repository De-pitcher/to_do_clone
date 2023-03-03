import 'package:flutter/material.dart';
import 'package:to_do_clone/enums/activity_type.dart';

import '../enums/planned_menu_value.dart';
import '../models/animated_list_model.dart';
import '../models/task.dart';
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
  const PlannedActivityWidget({
    super.key,
    this.bgImage,
    required this.title,
    required this.color,
    required this.tasks,
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
                // if (widget.unDoneListModel.isEmpty &&
                //     widget.completedListModel!.isEmpty)
                //   widget.emptyWidget ?? const Text('')
                // else if (widget.unDoneListModel.isEmpty &&
                //     widget.completedListModel!.isNotEmpty)
                //   AnimatedListWidget(
                //     listModel: _completedListModel,
                //     color: widget.color,
                //     itemBuilder: _buildCompletedTaskTile,
                //     onHide: _onHide,
                //     displayHeaderWidget: true,
                //     isExpanded: _isExpanded,
                //   )
                // else
                //   Expanded(
                //     child: Column(
                //       children: [
                //         AnimatedListWidget(
                //           listModel: _listModel,
                //           color: widget.color,
                //           itemBuilder: _buildTaskTile,
                //           displayHeaderWidget: false,
                //         ),
                //         AnimatedListWidget(
                //           listModel: _completedListModel,
                //           color: widget.color,
                //           itemBuilder: _buildCompletedTaskTile,
                //           onHide: _onHide,
                //           displayHeaderWidget: true,
                //           isExpanded: _isExpanded,
                //         )

                //       ],
                //     ),
                //   ),
                AnimatedListWidget(
                  listModel: _listModel,
                  color: widget.color,
                  itemBuilder: _buildTaskTile,
                  // onHide: _onHide,
                  displayHeaderWidget: false,
                  headerWidget: PlannedPopupMenu(color: widget.color),

                  // isExpanded: _isExpanded,
                )
              ],
            ),
          ),
        ),
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
      id: widget.tasks[index].id,
      animation: animation,
      color: widget.color,
      // onAddTaskFn: (task) => _insert(task, _listModel, index),
      // onRemoveFn: (item) => _remove(item, index, _listModel),
      // onRemoveFromUiFn: () =>
      // _removeFromUi(index, _listModel, _completedListModel),
      activityType: ActivityType.planned,
      // isSelected: _isSelected,
      // onLongPress: onLongPressed,
    );
  }
}
