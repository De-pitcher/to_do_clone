// ignore_for_file: public_member_api_docs, sort_constructors_first

/// [Task] contains data(infomations) about the task.
class Task {
  /// This is the [id] of the task.
  String id;

  /// This is the [task] where the task is defined. It is [String].
  final String task;

  /// This is the [step]s in achieving the task.
  final List<String> step;

  /// This is used to indicate if the task is done.
  bool isDone;

  /// This [isStarred] is used to check if the task is important.
  bool isStarred;

  /// This [myDay] is used to check if the task is added to [MyDayScreen].
  bool myDay;

  /// This [isSelected] is used to check if the task is currently selected.
  bool isSelected;

  Task({
    required this.id,
    required this.step,
    this.task = '',
    this.isDone = false,
    this.isStarred = false,
    this.myDay = false,
    this.isSelected = false,
  });

  Task copyWith({
    String? id,
    String? task,
    List<String>? step,
    bool? isDone,
    bool? isStarred,
    bool? myDay,
    bool? isSelected,
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
      step: step ?? this.step,
      isDone: isDone ?? this.isDone,
      isStarred: isStarred ?? this.isStarred,
      myDay: myDay ?? this.myDay,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
