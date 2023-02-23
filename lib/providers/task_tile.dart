import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

class TaskTileState extends ChangeNotifier {
  final Task _task = Task(id: const Uuid().v4(), step: []);

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
