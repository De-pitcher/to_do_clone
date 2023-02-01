import 'dart:io';

import 'package:flutter/material.dart';

class Activity {
  final DateTime key;
  final String title;
  final Color color;
  final String? image;
  final File? fileImage;
  final List<String> tasks;
  bool isSelected;
  Activity({
    required this.key,
    required this.title,
    required this.color,
    required this.tasks,
    this.image,
    this.fileImage,
    this.isSelected = false,
  });

  Activity copyWith({
    DateTime? key,
    String? title,
    Color? color,
    String? image,
    File? fileImage,
    List<String>? tasks,
    bool? isSelected,
  }) {
    return Activity(
      key: key ?? this.key,
      title: title ?? this.title,
      color: color ?? this.color,
      image: image ?? this.image,
      fileImage: fileImage ?? this.fileImage,
      tasks: tasks ?? this.tasks,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
