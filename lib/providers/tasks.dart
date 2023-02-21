import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get myDayTasks => _tasks.where((tks) => tks.myDay).toList();

  List<Task> get important => _tasks.where((tks) => tks.isStarred).toList();

  List<Task> get isDoneTasks => _tasks.where((tsk) => tsk.isDone).toList();

  List<Task> get unDoneTasks =>
      _tasks.where((tsk) => tsk.isDone == false).toList();

  void insert(Task task, [int? index]) {
    int cIndex = index != null && index != -1 ? index : _tasks.length;
    _tasks.insert(cIndex, task);
    notifyListeners();
  }

  Task removeTask(int index) => _tasks.removeAt(index);

  void insertAt(int index, Task task) {
    _tasks.insert(index, task);
    notifyListeners();
  }

  void renameTask(DateTime id, String newTaskName) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    if (newTaskName.isNotEmpty) {
      _tasks[currentIndex] = _tasks[currentIndex].copyWith(
        task: newTaskName,
      );
    }
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
    // print(tempIsStarred);
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
    notifyListeners();
  }

  void StarTask(DateTime id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    // final tempIsStarred = _tasks[currentIndex].isStarred;
    // // print(tempIsStarred);
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(isStarred: true);
    notifyListeners();
  }

  void toggleMyDay(DateTime id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempMyDay = _tasks[currentIndex].myDay;
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(myDay: !tempMyDay);
    notifyListeners();
  }
}
