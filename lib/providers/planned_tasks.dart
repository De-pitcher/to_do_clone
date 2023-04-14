import 'package:flutter/foundation.dart';

import '../models/task.dart';

class PlannedTasks extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> filteredTask = [];

  List<Task> get tasks => _tasks;

  String popupTitle = 'All planned';

  void changePopupTitle(String value) {
    popupTitle = value;
    notifyListeners();
  }

  void initTasks(List<Task> tasks) {
    _tasks = [...tasks.where((e) => e.remindMe || e.addDueDate)];
    filteredTask = _tasks;
    notifyListeners();
  }

  List<Task> filterTask(List<String> idList) {
    List<Task> tempList = [];
    for (var i = 0; i < idList.length; i++) {
      for (var element in _tasks) {
        if (element.id == idList[i]) {
          tempList.add(element);
        }
      }
    }
    filteredTask = tempList;
    return tempList;
  }
}
