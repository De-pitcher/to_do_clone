import 'package:flutter/material.dart';
import 'package:to_do_clone/models/list_model.dart';

// import '../models/list_model.dart';
import '../models/task.dart';

typedef RemovedItemBuilder<T> = Widget Function(
  T item,
  BuildContext context,
  Animation<double> animation,
);

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class Tasks with ChangeNotifier {
  final List<Task> _tasks = [];

  void insert(Task item, AnimatedListState? animatedListState) {
    int index = length - 1;
    print(index);
    if (animatedListState != null) {
      _tasks.insert(index++, item);
      //   print('It ran!!!!');
      animatedListState.insertItem(
        index++,
        duration: const Duration(milliseconds: 300),
      );
    }
    notifyListeners();
  }

  void addToList(Task task) {
    _tasks.add(task);
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

// class Tasks extends ChangeNotifier {
//   // late Task newTask;
//   // ListModel<Task>? _listModel;

//   final List<Task> _tasks = [];

//   List<Task> get tasks => _tasks;

//   void addToList(Task task) {
//     _tasks.add(task);
//     notifyListeners();
//   }

//   void renameTask(DateTime id, String newTaskName) {
//     final currentIndex = _tasks.indexWhere((e) => e.id == id);
//     if (newTaskName.isNotEmpty) {
//       _tasks[currentIndex] = _tasks[currentIndex].copyWith(
//         task: newTaskName,
//       );
//     }
//     notifyListeners();
//   }

//   int removeTask(DateTime id) {
//     final currentIndex = _tasks.indexWhere((e) => e.id == id);
//     _tasks.removeAt(currentIndex);
//     notifyListeners();
//     return currentIndex;
//   }

//   void addTaskAt(int index, Task task) {
//     _tasks.insert(index, task);
//     notifyListeners();
//   }

//   void toggleIsDone(DateTime id) {
//     final currentIndex = _tasks.indexWhere((e) => e.id == id);
//     final tempIsDoneVal = _tasks[currentIndex].isDone;
//     _tasks[currentIndex] =
//         _tasks[currentIndex].copyWith(isDone: !tempIsDoneVal);
//     notifyListeners();
//   }

//   void toggleIsStarred(DateTime id) {
//     final currentIndex = _tasks.indexWhere((e) => e.id == id);
//     final tempIsStarred = _tasks[currentIndex].isStarred;
//     _tasks[currentIndex] =
//         _tasks[currentIndex].copyWith(isStarred: !tempIsStarred);
//     notifyListeners();
//   }
// }
