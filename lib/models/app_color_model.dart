// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppColorModel {
  final int id;
  final Color? color;
  final List<Color> listOfColors;
  bool isSelected;
  AppColorModel({
    required this.id,
    this.color,
    required this.listOfColors,
     this.isSelected = false,
  });
   

  AppColorModel copyWith({
    int? id,
    Color? color,
    List<Color>? listOfColors,
    bool? isSelected,
  }) {
    return AppColorModel(
      id: id ?? this.id,
      color: color ?? this.color,
      listOfColors: listOfColors ?? this.listOfColors,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color?.value,
      'listOfColors': listOfColors.map((x) => x.value).toList(),
      'isSelected': isSelected,
    };
  }

  factory AppColorModel.fromMap(Map<String, dynamic> map) {
    return AppColorModel(
      id: map['id'] as int,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      listOfColors: List<Color>.from((map['listOfColors'] as List<int>).map<Color>((x) => Color(x),),),
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppColorModel.fromJson(String source) => AppColorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppColorModel(id: $id, color: $color, listOfColors: $listOfColors, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant AppColorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.color == color &&
      listEquals(other.listOfColors, listOfColors) &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      color.hashCode ^
      listOfColors.hashCode ^
      isSelected.hashCode;
  }
}
