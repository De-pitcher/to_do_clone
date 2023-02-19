import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/activity_widget.dart';
import '../../providers/tasks.dart';

class Important extends StatefulWidget {
  static const String id = '/important';
  const Important({super.key});

  @override
  State<Important> createState() => _ImportantState();
}

class _ImportantState extends State<Important> {
  @override
  Widget build(BuildContext context) {
    return ActivityWidget(listModel: ,);
  }
}
