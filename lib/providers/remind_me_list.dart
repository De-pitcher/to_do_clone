import 'package:flutter/foundation.dart';

import '../models/remind_me.dart';

class RemindMeList with ChangeNotifier {
  final List<RemindMe> _items = [];

  List<RemindMe> get items => _items;

  void addReminder(String id, DateTime date) {
    for (var item in _items) {
      if (item.id == id) {
        return;
      }
    }
    _items.add(RemindMe(id, date));
    notifyListeners();
  }

  RemindMe? getReminderById(String id) {
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
}
