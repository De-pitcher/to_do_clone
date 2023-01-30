import 'dart:io';

import 'package:flutter/material.dart';

import '../models/activity.dart';

class Activities extends ChangeNotifier {
  List<Activity> _activities = [];

  List<Activity> get activities => [..._activities];

  void addListActivity({
    required String title,
    required List<String> tasks,
    required Color color,
    String? image,
    File? fileImage,
  }) {
    _activities.add(
      Activity(
        key: DateTime.now(),
        title: title,
        color: color,
        image: image,
        fileImage: fileImage,
        tasks: tasks,
      ),
    );
    notifyListeners();
  }

  void addActivityFromScreen(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void removeActivity(int activityIndex) {
    _activities.removeAt(activityIndex);
    notifyListeners();
  }

  void addListOfActivities(List<Activity> activities) {
    _activities.addAll(activities);
    _activities = _activities.toSet().toList();
    notifyListeners();
  }

  void removeListOfActivities(List<Activity> activities) {
    for (var activity in activities) {
      _activities.removeWhere((e) => e.key == activity.key);
    }
    notifyListeners();
  }
}
