import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../models/group.dart';
import './list_tile_widget.dart';
import './group_header_widget.dart';
import '../providers/activities.dart';
import '../providers/groups.dart';

class DraggableListWidget extends StatefulWidget {
  const DraggableListWidget({super.key});

  @override
  State<DraggableListWidget> createState() => _DraggableListWidgetState();
}

class _DraggableListWidgetState extends State<DraggableListWidget> {
  late List<DragAndDropList> _contents;
  late List<DragAndDropList> _listContents;
  late List<DragAndDropList> _groupContents;

  final List<DragAndDropItem> _emptyDisplayWidget = [
    DragAndDropItem(
      child: Container(),
    ),
  ];

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
    final activities = Provider.of<Activities>(context).activities;
    _listContents = [
      DragAndDropList(
        children: activities.isEmpty
            ? _emptyDisplayWidget
            : _buildListTileWidget(context),
      ),
    ];

    final group = Provider.of<Groups>(context);
    _groupContents = group.groups.map((groups) {
      return DragAndDropList(
        header: GroupHeaderWidget(
          name: groups.name,
          expanded: groups.showList,
          onHide: () {
            Provider.of<Groups>(context, listen: false).hideList(groups.key);
          },
        ),
        children: groups.showList
            ? groups.lists.isEmpty
                ? _emptyListDisplayWidget
                : _buildGroupWidget(groups)
            : _emptyDisplayWidget,
      );
    }).toList();

    _contents = [..._listContents, ..._groupContents];
    super.didChangeDependencies();
  }

  List<DragAndDropItem> _buildListTileWidget(BuildContext context) {
    final activities = Provider.of<Activities>(context).activities;
    return activities.map((activity) {
      return DragAndDropItem(
        child: SizedBox(
          height: 50,
          child: ListTileWidget(
            activity: activity,
          ),
        ),
      );
    }).toList();
  }

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
                child: ListTileWidget(
                  activity: activity,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

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
      if (oldListIndex == 0 && oldItemIndex <= _listContents.length) {
        currentActivitiy = listActivities[oldItemIndex];
        activitiesProvider.removeActivity(oldItemIndex);
      } else {
        currentActivitiy = groups[oldListIndex - 1].lists[oldItemIndex];
        groupsProvider.removeList(oldListIndex - 1, oldItemIndex);
      }
      if (newListIndex < 1 && newListIndex <= _listContents.length) {
        activitiesProvider.addActivityFromScreen(currentActivitiy);
      } else {
        groupsProvider.addList(
          newListIndex - 1,
          newItemIndex,
          currentActivitiy,
        );
      }
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

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
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
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
