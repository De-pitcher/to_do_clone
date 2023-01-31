import 'package:flutter/foundation.dart';

import '../models/group.dart';
import '../models/activity.dart';

class Groups extends ChangeNotifier {
  List<Group> _groups = [];

  List<Group> get groups => [..._groups];

  String previousGroupName(DateTime key) {
    return _groups.firstWhere((e) => e.key == key).name;
  }

  void createGroup(
    String name, [
    List<Activity> lists = const [],
  ]) {
    _groups.add(Group(key: DateTime.now(), name: name, lists: lists));
    notifyListeners();
  }

  void renameGroup(DateTime key, String name) {
    if (name.isNotEmpty) {
      _groups = _groups..firstWhere((e) => e.key == key).name = name;
      notifyListeners();
    }
    return;
  }

  void hideList(DateTime key) {
    final itemIndex = _groups.indexWhere((e) => e.key == key);
    final showList = _groups[itemIndex].showList;
    _groups[itemIndex] = _groups[itemIndex].copyWith(showList: !showList);
    notifyListeners();
  }

  void addListUsingIndexs(
    int groupIndex,
    int listIndex,
    Activity activity,
  ) {
    final currentList = _groups[groupIndex].lists;
    activity = activity.copyWith(isSelected: true);
    currentList.insert(listIndex, activity);
    _groups[groupIndex] = _groups[groupIndex].copyWith(lists: currentList);
    notifyListeners();
  }

  void addListUsingKey(DateTime key, List<Activity> activities) {
    List<Activity> currentList = _groups.firstWhere((e) => e.key == key).lists;
    currentList.addAll(activities);
    currentList = currentList.toSet().toList();
    _groups = _groups..firstWhere((e) => e.key == key).lists = currentList;

    notifyListeners();
  }

  void removeList(int groupIndex, int listIndex) {
    _groups[groupIndex].lists.removeAt(listIndex);
    notifyListeners();
  }

  void removeListUsingKey(DateTime key, List<Activity> activities) {
    final currentList = _groups.firstWhere((e) => e.key == key).lists;

    final currentActivityIndex = _groups.indexWhere((e) => e.key == key);
    for (var activity in activities) {
      _groups[currentActivityIndex]
          .lists
          .removeWhere((e) => e.key == activity.key);
    }
    // currentList.removeAt(currentActivityIndex);
    _groups[currentActivityIndex] =
        _groups[currentActivityIndex].copyWith(lists: currentList);

    notifyListeners();
  }

  void swapGroup(
    int oldGroupIndex,
    int newGroupIndex,
    Group selectedGroup,
  ) {
    _groups.removeAt(oldGroupIndex);
    _groups.insert(newGroupIndex, selectedGroup);
    notifyListeners();
  }

  void deleteGroup(Group group) {
    _groups.remove(group);
    notifyListeners();
  }
}
