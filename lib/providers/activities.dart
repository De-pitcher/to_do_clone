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
          title: title,
          color: color,
          image: image,
          fileImage: fileImage,
          tasks: tasks),
    );
    notifyListeners();
  }
}
