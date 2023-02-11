

import 'package:flutter/material.dart';
import 'package:to_do_clone/widgets/step_tile.dart';

class TaskSteps extends ChangeNotifier {
  final List<Widget> _steps = [];

  List<Widget> get steps => _steps;

  void addStep(String newStep) {
    if (newStep.isNotEmpty) {
      var stepWidget = StepTile(step: newStep);
      _steps.add(stepWidget);
    }
    notifyListeners();
  }

  List<String> addToList(List<String> steps) {
    return [...steps];
  }
}
