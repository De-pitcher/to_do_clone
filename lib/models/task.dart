import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {

  String task;
  bool isDone;
  bool isStarred;

  Task({
    this.task = '',

    this.isDone = false,
    this.isStarred = false,
  });
}
