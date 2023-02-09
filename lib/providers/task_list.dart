import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/providers/task_tile.dart';

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
 