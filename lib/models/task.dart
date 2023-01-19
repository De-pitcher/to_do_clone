import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String task;
  bool isDone;
  bool isStarred;

  Task({
    required this.task,
    this.isDone = false,
    this.isStarred = false,
  });

  Task copyWith({
    String? task,
    bool? isDone,
    bool? isStarred,
  }) {
    return Task(
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      isStarred: isStarred ?? this.isStarred,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'isDone': isDone,
      'isStarred': isStarred,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      task: map['task'] as String,
      isDone: map['isDone'] as bool,
      isStarred: map['isStarred'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Task(task: $task, isDone: $isDone, isStarred: $isStarred)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.task == task &&
        other.isDone == isDone &&
        other.isStarred == isStarred;
  }

  @override
  int get hashCode => task.hashCode ^ isDone.hashCode ^ isStarred.hashCode;
}
