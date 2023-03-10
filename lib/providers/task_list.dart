import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskList extends ChangeNotifier {
  // late Task newTask;
  final List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  void addToList(String task) {
    Task newTask = Task(id: const Uuid().v4(), task: task, step: []);
    _taskList.add(newTask);

    notifyListeners();
  }
}
