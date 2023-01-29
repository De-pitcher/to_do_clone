class Task {
  String task;
  bool isDone;
  bool isStarred;

  List<String> steps = [];

  Task({
    this.task = '',
    this.isDone = false,
    this.isStarred = false,
  });
}
