// ignore_for_file: public_member_api_docs, sort_constructors_first

class Task {
  String  id;
  final String task;
  final List<String> step;
  bool isDone;
  bool isStarred;
  bool myDay;

  Task({
    required this.id,
    required this.step,
    this.task = '',
    this.isDone = false,
    this.isStarred = false,
    this.myDay = false,
  });

  Task copyWith({
    String? id,
    String? task,
    List<String>? step,
    bool? isDone,
    bool? isStarred,
    bool? myDay
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
      step: step ?? this.step,
      isDone: isDone ?? this.isDone,
      isStarred: isStarred ?? this.isStarred,
      myDay: myDay ?? this.myDay,
    );
  }
}
