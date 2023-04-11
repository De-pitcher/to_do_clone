import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../enums/enums.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/constants.dart';
import '../date_widget.dart';
import '../task_detail_option_widget.dart';
import '../../providers/remind_me_list.dart';

class RemindMePopupMenu extends StatefulWidget {
  final String id;
  final bool isEnabled;
  final Color color;
  // final PlannedMenuValue plannedMenuValue;
  const RemindMePopupMenu({
    super.key,
    required this.id,
    required this.isEnabled,
    required this.color,
    // required this.plannedMenuValue,
  });

  @override
  State<RemindMePopupMenu> createState() => _RemindMePopupMenuState();
}

class _RemindMePopupMenuState extends State<RemindMePopupMenu> {
  void _toggleRemindMe(bool value) {
    context.read<RemindMeList>().addReminder(widget.id, DateTime.now());
    if (value == true) {
      setState(() {
        context.read<Tasks>().toggleRemindMe(widget.id);
      });
    }
  }

  void setReminder({
    required RemindMePopupValue value,
    // required PlannedMenuValue plannedMenuValue,
    required String id,
    required DateTime date,
  }) {
    final now = DateTime.now();

    switch (value) {
      case RemindMePopupValue.laterToday:
        _toggleRemindMe(widget.isEnabled == false);
        context.read<RemindMeList>().setDateTime(
              id,
              DateTime(now.year, now.month, now.day, 22),
              PlannedMenuValue.today,
            );
        break;
      case RemindMePopupValue.tomorrow:
        _toggleRemindMe(widget.isEnabled == false);
        context.read<RemindMeList>().setDateTime(
              id,
              DateTime(now.year, now.month, now.day + 1, 21),
              PlannedMenuValue.tomorrow,
            );
        break;
      case RemindMePopupValue.nextWeek:
        _toggleRemindMe(widget.isEnabled == false);
        context.read<RemindMeList>().setDateTime(
            id,
            DateTime(now.year, now.month, now.day + 7, 21),
            PlannedMenuValue.later);
        break;
      case RemindMePopupValue.pickADateAndTime:
        showDialogFn(context, date);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final remindMeProvider = Provider.of<RemindMeList>(context);
    final remindMe = remindMeProvider.getReminderById(widget.id);
    final time = remindMe == null ? '' : DateFormat.jm().format(remindMe.date);
    return PopupMenuButton(
      itemBuilder: (_) => remindMePopMenuEntries(),
      position: PopupMenuPosition.under,
      offset: Offset.fromDirection(1),
      onSelected: (value) => setReminder(
        value: value,
        id: widget.id,
        date: remindMe?.date ?? DateTime.now(),
      ),
      child: TaskDetailsOptionWidget(
        title: 'Remind me ${widget.isEnabled ? 'at $time' : ''}',
        icon: widget.isEnabled
            ? Icons.notifications_off_outlined
            : Icons.notifications_outlined,
        subtitle: widget.isEnabled ? remindMe?.title ?? '' : null,
        isEnabled: widget.isEnabled,
        color: widget.isEnabled ? widget.color : Colors.grey,
        onCancel: () {
          context.read<Tasks>().toggleRemindMe(widget.id);
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
                  .read<RemindMeList>()
                  .addReminder(widget.id, DateTime.now());
              context.read<RemindMeList>().setDateTime(
                  widget.id, DateTime.parse(val), PlannedMenuValue.later);
            },
            onSubmit: () {
              _toggleRemindMe(widget.isEnabled == false);
              Navigator.of(context).pop();
            },
          );
        });
  }
}
