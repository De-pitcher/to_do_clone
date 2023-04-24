import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/activity.dart';
import '../../models/group.dart';
import '../../providers/groups.dart';
import '../../providers/activities.dart';

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
  @override
  Widget build(BuildContext context) {
    final allList = [...widget.activities, ...widget.group.lists];
    List<String> listOfKeys = [];
    for (var e in widget.group.lists) {
      listOfKeys.add(e.id);
    }
    final height = 70 * allList.length.toDouble();
    return SizedBox(
      height: height + 70,
      width: 300,
      child: Column(
        children: [
          SizedBox(
            height: height,
            width: 300,
            child: ListView.builder(
              itemBuilder: (_, i) {
                return ListTitleDialogWidget(
                  title: allList[i].title,
                  isSelected: allList[i].isSelected,
                  onTap: () {
                    setState(() {
                      allList[i].isSelected = !allList[i].isSelected;
                    });
                  },
                );
              },
              itemCount: allList.length,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  final groups = Provider.of<Groups>(context, listen: false);
                  final activities =
                      Provider.of<Activities>(context, listen: false);
                  final selectedList = allList
                      .where(
                        (activity) => activity.isSelected,
                      )
                      .toList();
                  final nonSelectedList = allList
                      .where(
                        (activity) => !activity.isSelected,
                      )
                      .toList();

                  groups.addListUsingKey(
                    widget.group.key,
                    selectedList,
                  );
                  groups.removeListUsingKey(
                    widget.group.key,
                    nonSelectedList,
                  );
                  activities.removeListOfActivities(selectedList);
                  activities.addListOfActivities(nonSelectedList);

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'SELECT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ListTitleDialogWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function()? onTap;
  const ListTitleDialogWidget({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.list),
      title: Text(title),
      onTap: onTap,
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.blue,
              )
            : const Icon(
                Icons.add,
                color: Colors.blue,
              ),
      ),
    );
  }
}
