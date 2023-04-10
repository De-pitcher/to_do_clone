import 'package:intl/intl.dart';

import '../enums/planned_menu_value.dart';

class RemindMe {
  final String id;
  final DateTime date;
  final PlannedMenuValue? plannedMenuValue;
  const RemindMe({
    required this.id,
    required this.date,
    this.plannedMenuValue,
  });

  String get title {
    if (date.day == DateTime.now().day) {
      return 'Today';
    } else if (date.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    }
    return DateFormat.E().add_MMMd().format(date);
  }

  RemindMe copyWith(
          {String? id, DateTime? date, PlannedMenuValue? plannedMenuValue}) =>
      RemindMe(
        id: id ?? this.id,
        date: date ?? this.date,
        plannedMenuValue: plannedMenuValue ?? this.plannedMenuValue,
      );
}
