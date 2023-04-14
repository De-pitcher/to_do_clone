import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../enums/planned_menu_value.dart';
import '../models/add_due_date.dart';

class AddDueDateList extends ChangeNotifier {
  final List<AddDueDate> _items = [];

  List<AddDueDate> get items => _items;

  void addReminder(String id, DateTime date) {
    for (var item in _items) {
      if (item.id == id) {
        return;
      }
    }
    _items.add(AddDueDate(id: id, date: date));
    notifyListeners();
  }

  AddDueDate? getReminderById(String id) {
    for (var item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  void setDateTime(String id, DateTime date) {
    final index = _items.indexWhere((item) => item.id == id);
    _items[index] = _items[index].copyWith(date: date);
    notifyListeners();
  }

  List<String> filterItem(PlannedMenuValue plannedMenuValue) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 22);
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 21);
    final nextWeek = DateTime(now.year, now.month, now.day + 7, 21);

    switch (plannedMenuValue) {
      case PlannedMenuValue.today:
        return _items.where((e) => e.date == today).map((e) => e.id).toList();
      case PlannedMenuValue.tomorrow:
        return _items
            .where((e) => e.date == tomorrow)
            .map((e) => e.id)
            .toList();
      case PlannedMenuValue.thisWeek:
        return _items
            .where((e) => e.date.isBefore(nextWeek) || e.date.isAfter(today))
            .map((e) => e.id)
            .toList();
      case PlannedMenuValue.later:
        return _items
            .where((e) => e.date.isAfter(nextWeek))
            .map((e) => e.id)
            .toList();
      case PlannedMenuValue.overDue:
        return _items
            .where((e) => e.date.isBefore(today))
            .map((e) => e.id)
            .toList();
      default:
        return _items.map((e) => e.id).toList();
    }
  }
}
