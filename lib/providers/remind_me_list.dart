import 'package:flutter/foundation.dart';

import '../models/remind_me.dart';

class RemindMeList with ChangeNotifier {
  final List<RemindMe> _items = [];

  List<RemindMe> get items => _items;
}
