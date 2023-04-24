import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/activity.dart';
import '../models/task.dart';

class Activities extends ChangeNotifier {
  List<Activity> _activities = [];

  List<Activity> get activities => [..._activities];

  List<Task> undoneTasks(String title) => _activities
      .firstWhere(
        (tks) => tks.title == title,
        orElse: () => Activity(
          color: Colors.blue,
          id: const Uuid().v1(),
          title: 'Untitled',
          tasks: [],
        ),
      )
      .tasks
      .where((tks) => !tks.isDone)
      .toList();

  List<Task> completedTasks(String title) => _activities
      .firstWhere(
        (tks) => tks.title == title,
        orElse: () => Activity(
          color: Colors.blue,
          id: const Uuid().v1(),
          title: 'Untitled',
          tasks: [],
        ),
      )
      .tasks
      .where((tks) => tks.isDone)
      .toList();
  // .firstWhere((tks) => tks.title == title)
  // .tasks
  // .where((tks) => !tks.isDone)
  // .toList();

  void insert(Task task, String title, [int? index]) {
    final indexWhere = _activities.indexWhere((e) => e.title == title);
    int cIndex = index ?? _activities[indexWhere].tasks.length;
    _activities[indexWhere].tasks.insert(cIndex, task);
    notifyListeners();
  }

  void addListActivity({
    required String id,
    required String title,
    required List<Task> tasks,
    required Color color,
    String? image,
    File? fileImage,
  }) {
    _activities.add(
      Activity(
        id: id,
        title: title,
        color: color,
        image: image,
        fileImage: fileImage,
        tasks: tasks,
      ),
    );
    notifyListeners();
  }

  void addActivityAtIndex(int index, Activity activity) {
    if (_activities.isEmpty) {
      _activities.add(activity);
    } else {
      _activities.insert(index, activity);
    }
    notifyListeners();
  }

  void removeActivity(int activityIndex) {
    _activities.removeAt(activityIndex);
    notifyListeners();
  }

  void addListOfActivities(List<Activity> activities) {
    // To make sure that the list is not selected in the list activities in
    // the group
    for (var i = 0; i < activities.length; i++) {
      activities[i].isSelected = false;
    }
    _activities.addAll(activities);
    _activities = _activities.toSet().toList();
    notifyListeners();
  }

  void removeListOfActivities(List<Activity> activities) {
    for (var activity in activities) {
      _activities.removeWhere((e) => e.id == activity.id);
    }
    notifyListeners();
  }
}
