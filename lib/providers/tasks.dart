import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get myDayTasks => _tasks.where((tks) => tks.myDay).toList();

  List<Task> get important => _tasks.where((tks) => tks.isStarred).toList();

  List<Task> get isDoneTasks => _tasks.where((tsk) => tsk.isDone).toList();

  List<Task> get unDoneTasks =>
      _tasks.where((tsk) => tsk.isDone == false).toList();

  List<Task> get selectedTask {
    return _tasks.where((tks) => tks.isSelected!).toList();
  }

  void insert(Task task, [int? index]) {
    int cIndex = index ?? _tasks.length;
    _tasks.insert(cIndex, task);
    notifyListeners();
  }

  void insertAt(int index, Task task) {
    _tasks.insert(index, task);
    notifyListeners();
  }

  void removeTask(Task task) {
    final index = _tasks.indexWhere((tks) => tks.id.contains(task.id));
    _tasks.removeAt(index);
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
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
    notifyListeners();
  }

  void starTask(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(isStarred: true);
    notifyListeners();
  }

  void toggleMyDay(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempMyDay = _tasks[currentIndex].myDay;
    _tasks[currentIndex] = _tasks[currentIndex].copyWith(myDay: !tempMyDay);
    notifyListeners();
  }

  void toggleIsSelected(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempIsSelected = _tasks[currentIndex].isSelected;
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isSelected: !tempIsSelected!);
    notifyListeners();
  }

  bool hasStarredTask() {
    var hasStarred = false;
    final selectedTask = _tasks.where((tks) => tks.isSelected!);
    for (var task in selectedTask) {
      hasStarred = task.isStarred;
    }
    return hasStarred;
  }

  bool isAllTaskSelected() {
    bool isSelected = false;
    for (var item in _tasks) {
      isSelected = item.isSelected!;
    }
    return isSelected;
  }

  void setSelectedTaskTo(bool value) {
    List<Task> tempTask = [];
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].isSelected = value;
      tempTask.add(_tasks[i]);
    }
    _tasks = tempTask;
    notifyListeners();
  }

  void starSelecedTask() {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isSelected!) {
        _tasks[i].isStarred = true;
      }
    }
    notifyListeners();
  }

  void deleteSelectedTask() {
    _tasks.removeWhere((tks) => tks.isSelected!);
    notifyListeners();
  }
}
