import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/add_due_date_pop_up_menu_entries.dart';
import '../task_detail_option_widget.dart';

class AddDueDatePopupMenu extends StatelessWidget {
  final Color color;
  const AddDueDatePopupMenu({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => addDueDatePopMenuEntries(),
      position: PopupMenuPosition.under,
      offset: Offset.fromDirection(1),
      onSelected: (value) {},
      child: TaskDetailsOptionWidget(
        title: 'Add due time',
        icon: CupertinoIcons.calendar,
        isEnabled: false,
        color: color,
      ),
    );
  }
}
