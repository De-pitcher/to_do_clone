import 'package:flutter/foundation.dart';

import '../models/group.dart';
import '../models/activity.dart';

class Groups extends ChangeNotifier {
  List<Group> _groups = [];

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

  void addList(
    int groupIndex,
    int listIndex,
    Activity activity,
  ) {
    // _groups[groupIndex].lists.add(activity);
    final currentList = _groups[groupIndex].lists;
    currentList.add(activity);
    _groups[groupIndex] = _groups[groupIndex].copyWith(lists: currentList);
    notifyListeners();
  }

  void removeList(int groupIndex, int listIndex) {
    _groups[groupIndex].lists.removeAt(listIndex);
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
