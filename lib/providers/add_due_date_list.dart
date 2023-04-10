import 'package:flutter/foundation.dart';

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

  void setDateTime(
    String id,
    DateTime date,
    // PlannedMenuValue plannedMenuValue,
  ) {
    final index = _items.indexWhere((item) => item.id == id);
    _items[index] = _items[index].copyWith(
      date: date,
      // plannedMenuValue: plannedMenuValue,
    );
    notifyListeners();
  }
}
