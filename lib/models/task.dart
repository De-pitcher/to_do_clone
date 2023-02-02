class Task {
  final DateTime id;
  final String task;
  final List<String> step;
  bool isDone;
  bool isStarred;

  Task({
    required this.id,
    required this.step,
    this.task = '',
    this.isDone = false,
    this.isStarred = false,
  });

  Task copyWith({
    DateTime? id,
    String? task,
    List<String>? step,
    bool? isDone,
    bool? isStarred,
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
      step: step ?? this.step,
      isDone: isDone ?? this.isDone,
      isStarred: isStarred ?? this.isStarred,
    );
  }
}
