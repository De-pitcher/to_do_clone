import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_clone/enums/activity_type.dart';

import '../../widgets/activity_widget.dart';
import '../../providers/tasks.dart';
import '../../widgets/buttons/special_button.dart';

class ImportantScreen extends StatefulWidget {
  static const String id = '/important';

  final Map<String, dynamic> args;
  const ImportantScreen({super.key, required this.args});

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  @override
  Widget build(BuildContext context) {
    return ActivityWidget(
      unDoneListModel: Provider.of<Tasks>(context).important,
      color: widget.args['color'],
      title: widget.args['action'],
      displaySubtitle: false,
      isExtended: false,
      fabIcon: const Icon(Icons.add, size: 32),
      activityType: ActivityType.important,
      specialButtons: const [
        SpecialButton(
          label: 'Set due date',
          icon: Icons.calendar_month_rounded,
        ),
        SpecialButton(
          label: 'Remind me',
          icon: Icons.notifications_on_outlined,
        ),
        SpecialButton(
          label: 'Repeat',
          icon: Icons.repeat,
        ),
      ],
      insert: (item, index) => context.read<Tasks>().insert(item, index),
      remove: (index) => context.read<Tasks>().removeTask(index),
    );
  }
}
