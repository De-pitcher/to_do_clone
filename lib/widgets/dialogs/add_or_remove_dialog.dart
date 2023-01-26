import 'package:flutter/material.dart';

import '../../models/activity.dart';
import '../../models/group.dart';
import '../list_tile_widget.dart';

class AddOrRemoveDialog extends StatefulWidget {
  final List<Activity> activities;
  final Group group;
  const AddOrRemoveDialog({
    super.key,
    required this.activities,
    required this.group,
  });

  @override
  State<AddOrRemoveDialog> createState() => _AddOrRemoveDialogState();
}

class _AddOrRemoveDialogState extends State<AddOrRemoveDialog> {
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    final allList = [...widget.activities, ...widget.group.lists];
    List<Activity> selectedList = [];
    List<DateTime> listOfKeys = [];
    for (var e in widget.group.lists) {
      listOfKeys.add(e.key);
    }
    return Container(
      height: 70 * allList.length.toDouble(),
      width: 300,
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemBuilder: (_, i) {
          // listOfKeys.contains(allList[i].key);
          return ListTileWidget(
            activity: allList[i],
            showTrailingIcon: true,
            isSelected: isSelected,
            onIconPressed: () {
              print('onPressed!');
              isSelected = !isSelected;
            },
          );
        },
        itemCount: allList.length,
      ),
    );
  }
}
