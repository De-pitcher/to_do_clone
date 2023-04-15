import 'package:flutter/material.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
  List<Task> get doneTasks => _tasks.where((tks) => tks.isDone).toList();

  List<Task> get undoneTasks => _tasks.where((tks) => !tks.isDone).toList();

  List<Task> get selectedTask {
    return _tasks.where((tks) => tks.isSelected).toList();
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

  Task getTaskById(String id) => _tasks.firstWhere((tks) => tks.id == id);

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
    _tasks[currentIndex] = _tasks[currentIndex]..isDone = !tempIsDoneVal;
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
        _tasks[currentIndex].copyWith(isSelected: !tempIsSelected);
    notifyListeners();
  }

  void toggleRemindMe(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempRemidMe = _tasks[currentIndex].remindMe;
    _tasks[currentIndex] = _tasks[currentIndex]..remindMe = !tempRemidMe;
    notifyListeners();
  }

  void toggleAddDueDate(String id) {
    final currentIndex = _tasks.indexWhere((e) => e.id == id);
    final tempAddDueDate = _tasks[currentIndex].addDueDate;
    _tasks[currentIndex] = _tasks[currentIndex]..addDueDate = !tempAddDueDate;
    notifyListeners();
  }

  bool hasStarredTask() {
    var hasStarred = false;
    final selectedTask = _tasks.where((tks) => tks.isSelected);
    for (var task in selectedTask) {
      hasStarred = task.isStarred;
    }
    return hasStarred;
  }

  bool hasMyDay() {
    var hasMyDay = false;
    final selectedTask = _tasks.where((tks) => tks.isSelected);
    for (var task in selectedTask) {
      hasMyDay = task.myDay;
    }
    return hasMyDay;
  }

  bool isAllTaskSelected() {
    for (var item in _tasks) {
      if (!item.isSelected) return false;
    }
    return true;
  }

  void setAllTaskToSelected(bool value) {
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
      if (_tasks[i].isSelected) {
        _tasks[i].isStarred = true;
      }
    }
    notifyListeners();
  }

  void setSelecedTaskToMyDay() {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isSelected) {
        _tasks[i].myDay = true;
      }
    }
    notifyListeners();
  }

  void deleteSelectedTask() {
    _tasks.removeWhere((tks) => tks.isSelected);
    notifyListeners();
  }
}
