import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../enums/add_due_date_pop_up_value.dart';
import '../../providers/add_due_date_list.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/add_due_date_pop_up_menu_entries.dart';
import '../date_widget.dart';
import '../task_detail_option_widget.dart';

class AddDueDatePopupMenu extends StatefulWidget {
  final String id;
  final bool isEnabled;
  final Color color;
  const AddDueDatePopupMenu({
    super.key,
    required this.color,
    required this.id,
    required this.isEnabled,
  });

  @override
  State<AddDueDatePopupMenu> createState() => _AddDueDatePopupMenuState();
}

class _AddDueDatePopupMenuState extends State<AddDueDatePopupMenu> {
  void _toggleRemindMe(bool value) {
    context.read<AddDueDateList>().addReminder(widget.id, DateTime.now());
    if (value == true) {
      setState(() {
        context.read<Tasks>().toggleAddDueDate(widget.id);
      });
    }
  }

  void setReminder({
    required AddDueDatePopupValue value,
    // required PlannedMenuValue plannedMenuValue,
    required String id,
    required DateTime date,
  }) {
    final now = DateTime.now();

    switch (value) {
      case AddDueDatePopupValue.today:
        _toggleRemindMe(widget.isEnabled == false);
        context
            .read<AddDueDateList>()
            .setDateTime(id, DateTime(now.year, now.month, now.day, 22));
        break;
      case AddDueDatePopupValue.tomorrow:
        _toggleRemindMe(widget.isEnabled == false);
        context
            .read<AddDueDateList>()
            .setDateTime(id, DateTime(now.year, now.month, now.day + 1, 21));
        break;
      case AddDueDatePopupValue.nextWeek:
        _toggleRemindMe(widget.isEnabled == false);
        context
            .read<AddDueDateList>()
            .setDateTime(id, DateTime(now.year, now.month, now.day + 7, 21));
        break;
      case AddDueDatePopupValue.pickADate:
        showDialogFn(context, date);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final addDueDateProvider = Provider.of<AddDueDateList>(context);
    final addDueDate = addDueDateProvider.getReminderById(widget.id);
    final time =
        addDueDate == null ? '' : DateFormat.jm().format(addDueDate.date);
    return PopupMenuButton(
      itemBuilder: (_) => addDueDatePopMenuEntries(),
      position: PopupMenuPosition.under,
      offset: Offset.fromDirection(1),
      onSelected: (value) => setReminder(
        value: value,
        id: widget.id,
        date: addDueDate?.date ?? DateTime.now(),
      ),
      child: TaskDetailsOptionWidget(
        title: widget.isEnabled
            ? 'Due ${addDueDate?.title ?? 'Date'}'
            : 'Add due date',
        icon: CupertinoIcons.calendar,
        isEnabled: widget.isEnabled,
        color: widget.isEnabled ? widget.color : Colors.grey,
        onCancel: () {
          context.read<Tasks>().toggleAddDueDate(widget.id);
        },
      ),
    );
  }

  Future<dynamic> showDialogFn(BuildContext context, DateTime date) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return DateWidget(
            date: date.toString(),
            onChanged: (val) {
              context
                  .read<AddDueDateList>()
                  .addReminder(widget.id, DateTime.now());
              context
                  .read<AddDueDateList>()
                  .setDateTime(widget.id, DateTime.parse(val));
            },
            onSubmit: () {
              _toggleRemindMe(widget.isEnabled == false);
              Navigator.of(context).pop();
            },
          );
        });
  }
}
