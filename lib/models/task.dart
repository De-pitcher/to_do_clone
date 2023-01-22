import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int id;
  String task;
  bool isDone;
  bool isStarred;

  Task({
    this.task = '',
    this.id = 0,
    this.isDone = false,
    this.isStarred = false,
  });
}
