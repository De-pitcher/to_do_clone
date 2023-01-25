import 'dart:io';

import 'package:flutter/material.dart';

class Activity {
  final DateTime key;
  final String title;
  final Color color;
  final String? image;
  final File? fileImage;
  final List<String> tasks;
  const Activity({
    required this.key,
    required this.title,
    required this.color,
    this.image,
    this.fileImage,
    required this.tasks,
  });

  Activity copyWith({
    DateTime? key,
    String? title,
    Color? color,
    String? image,
    File? fileImage,
    List<String>? tasks,
  }) {
    return Activity(
      key: key ?? this.key,
      title: title ?? this.title,
      color: color ?? this.color,
      image: image ?? this.image,
      fileImage: fileImage ?? this.fileImage,
      tasks: tasks ?? this.tasks,
    );
  }
}
