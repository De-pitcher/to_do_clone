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
}
