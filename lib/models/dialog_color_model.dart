import 'package:flutter/material.dart';

class DialogColorModel {
  final Color? color;
  final List<Color?> listOfColors;
  bool? isSelected;
  DialogColorModel({
    this.color,
    required this.listOfColors,
    this.isSelected = false,
  });
}
