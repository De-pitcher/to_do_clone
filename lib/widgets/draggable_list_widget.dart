import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import './list_widget.dart';
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

  @override
  void didChangeDependencies() {
    final activities = Provider.of<Activities>(context).activities;
    _listContents = [
      DragAndDropList(
        children: activities.isEmpty
            ? [
                DragAndDropItem(
                  child: Container(),
                ),
              ]
            : [
                ...activities.map((activities) {
                  return DragAndDropItem(
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        key: Key(activities.key.toString()),
                        leading: const Icon(Icons.list),
                        title: Text(activities.title),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ListWidget(
                                key: Key(activities.key.toString()),
                                title: activities.title,
                                bgColor: activities.color,
                                image: activities.image,
                                fileImage: activities.fileImage,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ],
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
                ? [
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
                  ]
                : groups.lists.map((activities) {
                    return DragAndDropItem(
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
                            child: ListTile(
                              key: Key(activities.key.toString()),
                              leading: const Icon(Icons.list),
                              title: Text(activities.title),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ListWidget(
                                      key: Key(activities.key.toString()),
                                      title: activities.title,
                                      bgColor: activities.color,
                                      image: activities.image,
                                      fileImage: activities.fileImage,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()
            : [
                DragAndDropItem(
                  child: Container(),
                ),
              ],
      );
    }).toList();

    _contents = [..._listContents, ..._groupContents];
    super.didChangeDependencies();
  }

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     Widget row = _contents.removeAt(oldIndex);
  //     _contents.insert(newIndex, row);
  //   });
  // }

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
      if (oldListIndex < 1 && oldItemIndex <= _listContents.length) {
        currentActivitiy = listActivities[oldItemIndex];
        print('listContent');
        print(currentActivitiy.toString());
        activitiesProvider.removeActivity(oldItemIndex);
      } else {
        print(oldListIndex);
        currentActivitiy = groups[oldListIndex - 1].lists[oldItemIndex];
        print('groupContent');
        print(currentActivitiy.toString());
        groupsProvider.removeList(oldItemIndex, oldItemIndex);
      }
      if (newListIndex < 1 && newListIndex <= _listContents.length) {
        activitiesProvider.addActivityFromScreen(currentActivitiy);
        print('currentListActivity added!');
      } else {
        groupsProvider.addList(
          newListIndex - 1,
          newItemIndex,
          currentActivitiy,
        );
        // print(groups[newItemIndex].lists.length);
        print('currentGroupActivity added!');
      }
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: DragAndDropLists(
        children: _contents,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
      ),
    );
    // return ReorderableColumn(
    //   onReorder: _onReorder,
    //   children: _contents,
    // );
  }
}
