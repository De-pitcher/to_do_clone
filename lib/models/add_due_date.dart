import 'package:intl/intl.dart';

class AddDueDate {
  final String id;
  final DateTime date;
  // final PlannedMenuValue? plannedMenuValue;
  const AddDueDate({
    required this.id,
    required this.date,
    // this.plannedMenuValue,
  });

  String get title {
    if (date.day == DateTime.now().day) {
      return 'Today';
    } else if (date.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    }
    return DateFormat.E().add_MMMd().format(date);
  }

  AddDueDate copyWith({String? id, DateTime? date}) => AddDueDate(
        id: id ?? this.id,
        date: date ?? this.date,
        // plannedMenuValue: plannedMenuValue ?? this.plannedMenuValue,
      );
}
