import 'package:flutter/foundation.dart';

import '../models/group.dart';

class Groups extends ChangeNotifier {
  List<Group> _groups = [];

  List<Group> get groups => [..._groups];

  void createGroup(String name, [List<String> tasks = const []]) {
    _groups.add(Group(name: name, tasks: tasks));
    notifyListeners();
  }
}
