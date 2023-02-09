import 'dart:async';

import 'package:flutter/material.dart';

import '../models/task.dart';

typedef RemovedItemBuilder<T> = Widget Function(
  T item,
  BuildContext context,
  Animation<double> animation,
);

class Tasks with ChangeNotifier {
  final List<Task> _tasks = [];

  // void insert(Task task, AnimatedListState? animatedList) {
  //   int index = length;
  //   _tasks.insert(index, task);
  //   if (animatedList != null) {
  //     animatedList.insertItem(
  //       index,
  //       duration: const Duration(milliseconds: 300),
  //     );
  //   }
  //   notifyListeners();
  // }

  void insertAt(Task task, AnimatedListState? animatedList, [int? index]) {
    int cIndex = length;
    if (index != null) {
      // print(cIndex);
      // _tasks.ins
      // _tasks[index] = task;
    }
    _tasks.insert(cIndex, task);
    // }
    if (animatedList != null) {
      animatedList.insertItem(
        cIndex,
        duration: const Duration(milliseconds: 300),
      );
    }
    notifyListeners();
  }

  void insert(int index, Task task) {
    _tasks.insert(index - 1, task);
    notifyListeners();
  }

  int removeTask(
    Task task,
    RemovedItemBuilder<Task> removedItemBuilder,
  ) {
    final index = indexOf(task);
    _tasks.removeAt(index);
    return index;
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
    _tasks[currentIndex] =
        _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
    notifyListeners();
  }

  int get length => _tasks.length;

  List<Task> get tasks => _tasks;

  Task operator [](int index) => _tasks[index];

  int indexOf(Task task) => _tasks.indexOf(task);
}
