import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskList extends ChangeNotifier {
  final List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  void addToList(Task newTask) {
    _taskList.add(newTask);

    notifyListeners();
  }
}
