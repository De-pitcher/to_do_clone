import 'dart:io';

import 'package:flutter/material.dart';

import '../models/app_color_model.dart';
import '../utils/constants/color_models.dart';
import '../enums/new_list_theme_value.dart';

class AppColor extends ChangeNotifier {
  List<AppColorModel> _colors = [...colorModels];

  List<Color> listOfSelectedColors = [];
  final List<String> _images = [...themeImages];
  final List<File> _fileImages = [];

  List<AppColorModel> get colors => [..._colors];
  List<String> get images => [..._images];
  List<File> get fileImages => [..._fileImages];

  NewListThemeValue newListThemeValue = NewListThemeValue.color;
  Color selectedColor = Colors.blue;
  String? selectedImage;
  File? selectedFileImage;
  String listTitle = 'Untitle list';

  void changeNewListThemeValue(NewListThemeValue newThemeValue) {
    newListThemeValue = newThemeValue;
    notifyListeners();
  }

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

        selectedImage = '';
      } else {
        tempColor[i].isSelected = false;
      }
    }
    selectedImage = null;
    selectedFileImage = null;
    _colors = tempColor;

    notifyListeners();
  }

  void selectImage(int cIndex) {
    for (var i = 0; i < _images.length; i++) {
      if (cIndex == i) {
        selectedFileImage = null;
        selectedImage = _images[i];
        // break;
      }
    }
    notifyListeners();
  }

  void addFileImage(File selectdFileImage) {
    _fileImages.add(selectdFileImage);
    selectedFileImage = selectdFileImage;
    selectedImage = null;
    notifyListeners();
  }

  void selectFileImage(int cIndex) {
    for (var i = 0; i < _fileImages.length; i++) {
      if (cIndex == i) {
        selectedImage = null;
        selectedFileImage = _fileImages[i];
      }
    }
    notifyListeners();
  }

  void updateListTitle(String updatedListTitle) {
    if (updatedListTitle.isNotEmpty || listTitle.startsWith('Untitle')) {
      listTitle = updatedListTitle;
    }
    notifyListeners();
  }

  void resetListTitle() {
    listTitle = 'Untitle list';
    notifyListeners();
  }
}
