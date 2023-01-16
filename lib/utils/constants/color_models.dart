import 'package:flutter/material.dart';

import '../../models/app_color_model.dart';

List<AppColorModel> colorModels = [
  AppColorModel(id: 0, color: Colors.blue, listOfColors: []),
  AppColorModel(id: 1, color: Colors.purple, listOfColors: []),
  AppColorModel(id: 2, color: Colors.pink, listOfColors: []),
  AppColorModel(id: 3, color: Colors.orange, listOfColors: []),
  AppColorModel(id: 4, color: Colors.green, listOfColors: []),
  AppColorModel(id: 5, color: Colors.teal, listOfColors: []),
  AppColorModel(id: 6, color: Colors.grey, listOfColors: []),
  AppColorModel(
    id: 7,
    listOfColors: [
      Colors.blue,
      Colors.lightBlue[100]!,
    ],
  ),
  AppColorModel(
    id: 8,
    listOfColors: [
      Colors.purple,
      Colors.purpleAccent[100]!,
    ],
  ),
  AppColorModel(
    id: 9,
    listOfColors: [
      Colors.orange,
      Colors.orangeAccent[100]!,
    ],
  ),
  AppColorModel(
    id: 10,
    listOfColors: [
      Colors.green,
      Colors.greenAccent[100]!,
    ],
  ),
  AppColorModel(
    id: 11,
    listOfColors: [
      Colors.teal,
      Colors.tealAccent[100]!,
    ],
  ),
  AppColorModel(
    id: 12,
    listOfColors: [
      Colors.grey,
      Colors.white,
    ],
  ),
];
