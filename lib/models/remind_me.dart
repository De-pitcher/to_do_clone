import 'task.dart';

class RemindMe {
  final Task task;
  final DateTime date;
  const RemindMe(this.task, this.date);

  RemindMe copyWith({Task? task, DateTime? date}) =>
      RemindMe(task ?? this.task, date ?? this.date);
}
