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

  
}




