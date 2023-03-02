import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:to_do_clone/models/remind_me.dart';

import '../../enums/enums.dart';
import '../../providers/tasks.dart';
import '../../utils/constants/constants.dart';
import '../task_detail_option_widget.dart';
import '../../providers/remind_me_list.dart';

class RemindMePopupMenu extends StatefulWidget {
  final String id;
  final bool isEnabled;
  final Color color;
  const RemindMePopupMenu({
    super.key,
    required this.id,
    required this.isEnabled,
    required this.color,
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

  void setReminder(RemindMePopupValue value, String id, DateTime date) {
    final now = DateTime.now();

    switch (value) {
      case RemindMePopupValue.laterToday:
        _toggleRemindMe(widget.isEnabled == false);
        context.read<RemindMeList>().setDateTime(
              id,
              DateTime(
                now.year,
                now.month,
                now.day,
                22,
              ),
            );
        break;
      case RemindMePopupValue.tomorrow:
        context.read<RemindMeList>().setDateTime(
              id,
              DateTime(
                now.year,
                now.month,
                now.day + 1,
                21,
              ),
            );
        break;
      case RemindMePopupValue.nextWeek:
        context.read<RemindMeList>().setDateTime(
              id,
              DateTime(
                now.year,
                now.month,
                now.day + 7,
                21,
              ),
            );
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
      itemBuilder: (ctx) => remindMePopMenuEntries(ctx),
      position: PopupMenuPosition.under,
      offset: Offset.fromDirection(1),
      onSelected: (value) => setReminder(
        value,
        widget.id,
        remindMe?.date ?? DateTime.now(),
      ),
      child: TaskDetailsOptionWidget(
        title: 'Remind me ${widget.isEnabled ? 'at $time' : ''}',
        icon: Icons.notifications_outlined,
        subtitle: widget.isEnabled ? remindMe?.title ?? '' : null,
        isEnabled: widget.isEnabled,
        color: widget.color,
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
              context
                  .read<RemindMeList>()
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

class DateWidget extends StatelessWidget {
  final String date;
  final Function(String)? onChanged;
  final Function()? onSubmit;
  const DateWidget({
    super.key,
    required this.date,
    this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'd MMM, yyyy',
                  initialValue: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  timeLabelText: "Hour",
                  selectableDayPredicate: (date) {
                    // Disable weekend days to select from the calendar
                    if (date.weekday == 6 || date.weekday == 7) {
                      return false;
                    }
                    return true;
                  },
                  onChanged: onChanged),
            ),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('OK'),
            )
          ],
        ),
      ),
    );
  }
}