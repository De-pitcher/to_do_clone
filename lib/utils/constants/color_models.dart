import 'package:flutter/material.dart';

import '../../models/list_theme_model.dart';

List<ListThemeModel> colorModels = [
  ListThemeModel(id: 0, color: Colors.blue, listOfColors: []),
  ListThemeModel(id: 1, color: Colors.purple, listOfColors: []),
  ListThemeModel(id: 2, color: Colors.pink, listOfColors: []),
  ListThemeModel(id: 3, color: Colors.orange, listOfColors: []),
  ListThemeModel(id: 4, color: Colors.green, listOfColors: []),
  ListThemeModel(id: 5, color: Colors.teal, listOfColors: []),
  ListThemeModel(id: 6, color: Colors.grey, listOfColors: []),
  ListThemeModel(
    id: 7,
    listOfColors: [
      Colors.blue,
      Colors.lightBlue[100]!,
    ],
  ),
  ListThemeModel(
    id: 8,
    listOfColors: [
      Colors.purple,
      Colors.purpleAccent[100]!,
    ],
  ),
  ListThemeModel(
    id: 9,
    listOfColors: [
      Colors.orange,
      Colors.orangeAccent[100]!,
    ],
  ),
  ListThemeModel(
    id: 10,
    listOfColors: [
      Colors.green,
      Colors.greenAccent[100]!,
    ],
  ),
  ListThemeModel(
    id: 11,
    listOfColors: [
      Colors.teal,
      Colors.tealAccent[100]!,
    ],
  ),
  ListThemeModel(
    id: 12,
    listOfColors: [
      Colors.grey,
      Colors.white,
    ],
  ),
];

List<String> themeImages = [
  'assets/images/image.jpeg',
  'assets/images/image2.jpeg',
  'assets/images/image3.jpeg',
  'assets/images/image4.jpeg',
  'assets/images/image5.jpeg',
  'assets/images/image6.jpeg',
  'assets/images/image7.jpeg',
];
