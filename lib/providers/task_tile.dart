import 'package:flutter/cupertino.dart';
import 'package:to_do_clone/models/task.dart';

class TaskTileState extends ChangeNotifier {
  bool _isDone = false;
  bool _isStarred = false;

  bool get isDone => _isDone;

  bool get isStarred => _isStarred;

  void done() {
    _isDone = !isDone;
    notifyListeners();
  }

  void starred() {
    _isStarred = !_isStarred;
    notifyListeners();
  }
}
