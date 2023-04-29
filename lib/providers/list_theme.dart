import 'dart:io';

import 'package:flutter/material.dart';

import '../models/list_theme_model.dart';
import '../utils/constants/color_models.dart';
import '../enums/new_list_theme_value.dart';

/// [ListTheme] is a class that handles the state of theming as regards
/// to [ListWidget]
class ListTheme extends ChangeNotifier {
  //* Holds the list of colors
  List<ListThemeModel> _colors = [...colorModels];

  /// This variable [listOfSelectedColors] holds the list of selected colors
  List<Color> listOfSelectedColors = [];

  //* Holds the list of images
  final List<String> _images = [...themeImages];

  //* Holds the list of file images
  final List<File> _fileImages = [];

  /// This [colors] returns the list of colors
  List<ListThemeModel> get colors => [..._colors];

  /// This [images] returns the list of images
  List<String> get images => [..._images];

  /// This [fileImages] returns the list of file images
  List<File> get fileImages => [..._fileImages];

  /// This [newListThemeValue] holds the reference to the current
  /// [NewListThemeValue]
  NewListThemeValue newListThemeValue = NewListThemeValue.color;

  /// This [selectedColor] holds the reference to the currently selected color
  Color selectedColor = Colors.blue;

  /// This [selectedImage] holds the reference to the currently selected image
  String? selectedImage;

  /// This [selectedFileImage] holds the reference to the currently selected
  /// file image
  File? selectedFileImage;

  /// This [listTitle] holds the reference to the current list
  String listTitle = 'Untitle list';

  /// [changeNewListThemeValue] changes and updates the [newListThemeValue]
  void changeNewListThemeValue(NewListThemeValue newThemeValue) {
    newListThemeValue = newThemeValue;
    notifyListeners();
  }

  /// [selectCurrentColor] changes and updates the [selectedColor]
  void selectCurrentColor(ListThemeModel currentColorModel) {
    List<ListThemeModel> tempColor = List.from(_colors);

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

  /// [selectImage] selects an image and assign the null to the
  /// [selectedFileImage]
  void selectImage(int cIndex) {
    for (var i = 0; i < _images.length; i++) {
      if (cIndex == i) {
        selectedFileImage = null;
        selectedImage = _images[i];
      }
    }
    notifyListeners();
  }

  /// [addFileImage] adds a [FileImage] to the [fileImages]
  void addFileImage(File selectdFileImage) {
    _fileImages.add(selectdFileImage);
    selectedFileImage = selectdFileImage;
    selectedImage = null;
    notifyListeners();
  }

  /// [selectFileImage] selects an file image and assign the null to the
  /// [selectedImage]
  void selectFileImage(int cIndex) {
    for (var i = 0; i < _fileImages.length; i++) {
      if (cIndex == i) {
        selectedImage = null;
        selectedFileImage = _fileImages[i];
      }
    }
    notifyListeners();
  }

  /// [updateListTitle] updates the list title if the params is not empty
  /// otherwise it assigns "Untitle list" to it
  void updateListTitle(String updatedListTitle) {
    if (updatedListTitle.isNotEmpty || listTitle.startsWith('Untitle')) {
      listTitle = updatedListTitle;
    }
    notifyListeners();
  }

  /// [resetListThemeData] sets the [ListTheme] data to the default value. This method
  /// is called after a [ListWidget] is created
  void resetListThemeData() {
    listTitle = 'Untitle list';
    selectedColor = Colors.blue;
    selectedImage = null;
    selectedFileImage = null;
    notifyListeners();
  }
}
