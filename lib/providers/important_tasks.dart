import 'package:flutter/foundation.dart';

import '../models/task.dart';

class ImportantTasks extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get doneTask => _tasks.where((tks) => tks.isDone).toList();

  List<Task> get undoneTasks => _tasks.where((tks) => !tks.isDone).toList();

  void initTasks(List<Task> tasks) {
    _tasks = [...tasks.where((e) => e.isStarred)];
    notifyListeners();
  }
}
