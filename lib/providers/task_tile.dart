import 'package:flutter/cupertino.dart';
import '../models/task.dart';

class TaskTileState extends ChangeNotifier {
  final Task _task = Task(id: DateTime.now(), step: []);

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
