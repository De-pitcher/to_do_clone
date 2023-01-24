import 'package:flutter/material.dart';
import 'package:to_do_clone/models/task.dart';

class TaskDetailsSteps extends ChangeNotifier {
  final List<Task> _steps = [];

  List<Task> get steps => _steps;

  void addStep(String step) {
    final Task newStep = Task(task: step);
    _steps.add(newStep);
  }
}
