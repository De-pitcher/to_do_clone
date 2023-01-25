import 'dart:io';

import 'package:flutter/material.dart';

import '../models/activity.dart';

class Activities extends ChangeNotifier {
  final List<Activity> _activities = [];

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
}
