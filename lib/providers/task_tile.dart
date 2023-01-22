import 'package:flutter/cupertino.dart';
import 'package:to_do_clone/models/task.dart';

class TaskTileState extends ChangeNotifier {
  final Task _task = Task();

  Task get task => _task;

  void done() {
    _task.isDone = !_task.isDone;
    notifyListeners();
  }

  void starred() {
    _task.isStarred = !_task.isStarred;
    notifyListeners();
  }
}
