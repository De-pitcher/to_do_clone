import 'package:flutter/foundation.dart';

import '../models/task.dart';

class PlannedTasks extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void initTasks(List<Task> tasks) {
    _tasks = [...tasks.where((e) => e.remindMe || e.addDueDate)];
    notifyListeners();
  }
}
