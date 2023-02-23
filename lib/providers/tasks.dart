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
    int cIndex = index ?? _tasks.length;
    _tasks.insert(cIndex, task);
    print(_tasks.length);
    notifyListeners();
  }

  void removeTask(Task task) {
    final index = _tasks.indexWhere((tks) => tks.id.contains(task.id));
    final item = _tasks.firstWhere((tks) => tks.id.contains(task.id));
    _tasks.removeAt(index);
    print(item.task);
    print(task.id);
    // print(_tasks.length);
    notifyListeners();
  }

  void insertAt(int index, Task task) {
    _tasks.insert(index, task);
    notifyListeners();
  }

  void renameTask(String id, String newTaskName) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    if (newTaskName.isNotEmpty) {
      _tasks[currentIndex] = _tasks[currentIndex].copyWith(
        task: newTaskName,
      );
    }
    notifyListeners();
  }

  void toggleIsDone(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempIsDoneVal = _tasks[currentIndex].isDone;
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isDone: !tempIsDoneVal);
    notifyListeners();
  }

  void toggleIsStarred(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempIsStarred = _tasks[currentIndex].isStarred;
    // print(tempIsStarred);
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
    notifyListeners();
  }

  void StarTask(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    // final tempIsStarred = _tasks[currentIndex].isStarred;
    // // print(tempIsStarred);
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(isStarred: true);
    notifyListeners();
  }

  void toggleMyDay(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempMyDay = _tasks[currentIndex].myDay;
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(myDay: !tempMyDay);
    notifyListeners();
  }
}
