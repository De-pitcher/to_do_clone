import 'dart:io';

import 'package:flutter/material.dart';

import 'task.dart';

class Activity {
  final String id;
  final String title;
  final Color color;
  final String? image;
  final File? fileImage;
  final List<Task> tasks;
  bool isSelected;

  Activity({
    required this.id,
    required this.title,
    required this.color,
    required this.tasks,
    this.image,
    this.fileImage,
    this.isSelected = false,
  });

  Activity copyWith({
    String? id,
    String? title,
    Color? color,
    String? image,
    File? fileImage,
    List<Task>? tasks,
    bool? isSelected,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      image: image ?? this.image,
      fileImage: fileImage ?? this.fileImage,
      tasks: tasks ?? this.tasks,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
