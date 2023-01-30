import './activity.dart';

class Group {
  final String name;
  final DateTime key;
  List<Activity> lists;
  bool showList;
  Group({
    required this.key,
    required this.name,
    required this.lists,
    this.showList = false,
  });
  Group copyWith({
    DateTime? key,
    String? name,
    List<Activity>? lists,
    bool? showList,
  }) {
    return Group(
      key: key ?? this.key,
      name: name ?? this.name,
      lists: lists ?? this.lists,
      showList: showList ?? this.showList,
    );
  }
}
