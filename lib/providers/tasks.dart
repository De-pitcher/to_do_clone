import 'package:flutter/material.dart';

import '../models/task.dart';

typedef RemovedItemBuilder<T> = Widget Function(
  T item,
  BuildContext context,
  Animation<double> animation,
);

class Tasks with ChangeNotifier {
  final List<Task> _tasks = [];

  void insert(Task item, AnimatedListState? animatedList) {
    int index = length;
    _tasks.insert(index, item);
    if (animatedList != null) {
      animatedList.insertItem(
        index,
        duration: const Duration(milliseconds: 300),
      );
    }
    notifyListeners();
  }

  Task? removeAt(int index, RemovedItemBuilder<Task> removedItemBuilder) {
    final Task removedItem = _tasks.removeAt(index);
    return removedItem;
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

  int indexOf(Task item) => _tasks.indexOf(item);
}