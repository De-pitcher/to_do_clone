import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks extends ChangeNotifier {
  // late Task newTask;
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addToList(String task) {
    Task newTask = Task(
      id: DateTime.now(),
      task: task,
      step: [],
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleIsDone(DateTime id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempIsDoneVal = _tasks[currentIndex].isDone;
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isDone: !tempIsDoneVal);
    notifyListeners();
  }

  void toggleIsStarred(DateTime id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempIsStarred = _tasks[currentIndex].isStarred;
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
    notifyListeners();
  }
}
