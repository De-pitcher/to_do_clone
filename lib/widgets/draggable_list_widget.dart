import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/dialogs/group_dialog.dart';
import '../enums/group_pop_menu_value.dart';
import '../models/activity.dart';
import '../models/group.dart';
import 'list_tile_widget.dart';
import 'group_header_widget.dart';
import 'dialogs/add_or_remove_dialog.dart';
import '../providers/activities.dart';
import '../providers/groups.dart';

class DraggableListWidget extends StatefulWidget {
  /// [DraggableListWidget] displays the list and group of lists widgets where
  /// an actual task tile can be created. And this list is draggable
  const DraggableListWidget({super.key});

  @override
  State<DraggableListWidget> createState() => _DraggableListWidgetState();
}

class _DraggableListWidgetState extends State<DraggableListWidget> {
  /// [_contents] holds both the [_listContents] and [_groupContents]
  late List<DragAndDropList> _contents;

  /// [_listContents] holds the list of task tiles
  late List<DragAndDropList> _listContents;

  /// [_groupContents] holds the list of [_listContents]
  late List<DragAndDropList> _groupContents;

  /// displays an empty container
  final List<DragAndDropItem> _emptyDisplayWidget = [
    DragAndDropItem(
      child: Container(),
    ),
  ];

  /// Displays a widget when the list is empty
  final List<DragAndDropItem> _emptyListDisplayWidget = [
    DragAndDropItem(
      child: Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: const [
            SizedBox(
              height: 70,
              child: VerticalDivider(
                width: 5,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Text(
                'Tap and drag here to add lists',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    ),
  ];

  @override
  void didChangeDependencies() {
    //* [_listContents], [_groupContents] and [_contents] is initialized
    //* here

    final activities = Provider.of<Activities>(context).activities;
    _listContents = [
      DragAndDropList(
        children: activities.isEmpty
            ? _emptyDisplayWidget
            : _buildListTileWidget(context),
      ),
    ];

    final groupProvider = Provider.of<Groups>(context);
    _groupContents = groupProvider.groups.map((group) {
      return DragAndDropList(
        header: GroupHeaderWidget(
          name: group.name,
          expanded: group.showList,
          isEmpty: group.lists.isEmpty,
          onHide: () {
            Provider.of<Groups>(context, listen: false).hideList(group.key);
          },
          onPopMenuItemSelected: (value) {
            //* Handles the actions of the [PopMenuItem]s
            switch (value) {
              case GroupPopMenuValue.addOrRemove:
                return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Select lists to add or remove'),
                        content: AddOrRemoveDialog(
                          activities: activities,
                          group: group,
                        ),
                      );
                    });
              case GroupPopMenuValue.renameGroup:
                return showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: GroupDialog(
                          onCreatePressed: (title) {
                            Provider.of<Groups>(context, listen: false)
                                .renameGroup(group.key, title);
                          },
                          initialFieldValue:
                              Provider.of<Groups>(context, listen: false)
                                  .previousGroupName(group.key),
                          actionButtonTitle: 'RENAME',
                        ),
                      );
                    });
              case GroupPopMenuValue.ungroup:
                Provider.of<Activities>(context, listen: false)
                    .addListOfActivities(group.lists);
                Provider.of<Groups>(context, listen: false).deleteGroup(group);
                break;
              case GroupPopMenuValue.deleteGroup:
                Provider.of<Groups>(context, listen: false).deleteGroup(group);
                break;
              default:
            }
          },
        ),
        children: group.showList
            ? group.lists.isEmpty
                ? _emptyListDisplayWidget
                : _buildGroupWidget(group)
            : _emptyDisplayWidget,
      );
    }).toList();

    _contents = [..._listContents, ..._groupContents];
    super.didChangeDependencies();
  }

  /// Builds list title widget
  List<DragAndDropItem> _buildListTileWidget(BuildContext context) {
    final activities = Provider.of<Activities>(context).activities;
    return activities.map((activity) {
      return DragAndDropItem(
        child: SizedBox(
          height: 50,
          child: ListTileWidget(activity),
        ),
      );
    }).toList();
  }

  /// Builds [GroupHeaderWidget]
  List<DragAndDropItem> _buildGroupWidget(Group group) {
    return group.lists.map((activity) {
      return DragAndDropItem(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const SizedBox(
                height: 60,
                child: VerticalDivider(
                  width: 5,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: ListTileWidget(activity),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  /// Handles the reorder of the item in the list or group of lists
  _onItemReorder(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    Activity currentActivitiy;
    final activitiesProvider = Provider.of<Activities>(context, listen: false);
    final groupsProvider = Provider.of<Groups>(context, listen: false);
    final listActivities = activitiesProvider.activities;
    final groups = groupsProvider.groups;
    setState(() {
      // print('Debug oldlistItemIndex: $oldItemIndex');
      // print('Debug oldListIndex: $oldListIndex');
      // print('Debug newItemIndex: $newItemIndex');
      // print('Debug newListIndex: $newListIndex');
      if (oldItemIndex == 0 &&
              oldListIndex == 0 &&
              newItemIndex == 0 &&
              newListIndex == 0 ||
          (oldListIndex == newListIndex && oldItemIndex == newItemIndex)) {
        return;
      }
      if (oldListIndex == 0 && _listContents.isNotEmpty) {
        currentActivitiy = listActivities[oldItemIndex];
        activitiesProvider.removeActivity(oldItemIndex);
      } else {
        currentActivitiy = groups[oldListIndex - 1].lists[oldItemIndex];
        groupsProvider.removeList(oldListIndex - 1, oldItemIndex);
      }

      if (oldListIndex == newItemIndex && newListIndex == 0 ||
          (oldListIndex > 0 && newListIndex == 0)) {
        activitiesProvider.addActivityAtIndex(newItemIndex, currentActivitiy);
      } else {
        groupsProvider.addListUsingIndexs(
          newListIndex - 1,
          newItemIndex,
          currentActivitiy,
        );
      }
      // var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      // _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  /// Handles the reorder of lists and group of lists
  _onListReorder(
    int oldListIndex,
    int newListIndex,
  ) {
    final groupsProvider = Provider.of<Groups>(context, listen: false);
    setState(() {
      if (oldListIndex != 0 && newListIndex != 0) {
        final group = groupsProvider.groups[oldListIndex - 1];
        groupsProvider.swapGroup(
          oldListIndex - 1,
          newListIndex - 1,
          group,
        );
      }
      // var movedList = _contents.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragAndDropLists(
      children: _contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
    );
  }
}
