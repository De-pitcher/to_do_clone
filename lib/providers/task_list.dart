import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskList extends ChangeNotifier {
  // late Task newTask;
  final List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  void addToList(String task) {
    Task newTask = Task(id: DateTime.now(), task: task, step: []);
    _taskList.add(newTask);
 
    notifyListeners();
  }
}
 