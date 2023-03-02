import 'package:intl/intl.dart';

class RemindMe {
  final String id;
  final DateTime date;
  const RemindMe(this.id, this.date);

  String get title {
    if (date.day == DateTime.now().day) {
      return 'Today';
    } else if (date.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    }
    return DateFormat.E().add_MMMd().format(date);
  }

  RemindMe copyWith({String? id, DateTime? date}) =>
      RemindMe(id ?? this.id, date ?? this.date);
}
