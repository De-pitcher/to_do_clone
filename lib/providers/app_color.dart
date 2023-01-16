import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/app_color_model.dart';
import '../utils/constants/color_models.dart';

class AppColor extends ChangeNotifier {
  List<AppColorModel> _colors = [...colorModels];

  Color selectedColor = Colors.blue;

  List<Color> listOfSelectedColors = [];

  List<AppColorModel> get colors => [..._colors];

  void selectCurrentColor(AppColorModel currentColorModel) {
    List<AppColorModel> tempColor = List.from(_colors);

    for (var i = 0; i < tempColor.length; i++) {
      if (tempColor[i].id == currentColorModel.id) {
        tempColor[i].isSelected = true;

        selectedColor = (tempColor[i].color ??
            (tempColor[i].listOfColors.isNotEmpty
                ? tempColor[i].listOfColors.first
                : Colors.blue));
        listOfSelectedColors =
            tempColor[i].listOfColors.isEmpty ? [] : tempColor[i].listOfColors;
      } else {
        tempColor[i].isSelected = false;
      }
    }
    _colors = tempColor;

    notifyListeners();
  }
}
