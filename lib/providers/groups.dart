import 'package:flutter/foundation.dart';

import '../models/group.dart';
import '../models/activity.dart';

class Groups extends ChangeNotifier {
  final List<Group> _groups = [];

  List<Group> get groups => [..._groups];

  void createGroup(
    String name, [
    List<Activity> lists = const [],
  ]) {
    _groups.add(Group(key: DateTime.now(), name: name, lists: lists));
    notifyListeners();
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
    currentList.add(activity);
    _groups[groupIndex] = _groups[groupIndex].copyWith(lists: currentList);
    notifyListeners();
  }

  void addListUsingKey(DateTime key, List<Activity> activities) {
    // final currentActivityIndex = _groups.indexWhere((e) => e.key == key);
    // currentList.add(activity);
    // _groups[currentActivityIndex] =
    //     _groups[currentActivityIndex].copyWith(lists: currentList);
    final currentList = _groups.firstWhere((e) => e.key == key).lists;
    currentList.addAll(activities);
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
}
