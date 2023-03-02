import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/enums.dart';
import '../../utils/constants/constants.dart';
import '../task_detail_option_widget.dart';

class RemindMePopupMenu extends StatefulWidget {
  final bool isEnabled;
  final Color color;
  const RemindMePopupMenu({
    super.key,
    required this.isEnabled,
    required this.color,
  });

  @override
  State<RemindMePopupMenu> createState() => _RemindMePopupMenuState();
}

class _RemindMePopupMenuState extends State<RemindMePopupMenu> {
  DateTime? date;
  String formateDate(DateTime date) {
    if (date == DateTime.now()) {
      return 'Today';
    } else if (date.day == DateTime.now().day + 1) {
      return 'Tomorrow';
    }
    return DateFormat.E().add_MMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (ctx) => remindMePopMenuEntries(ctx),
      position: PopupMenuPosition.under,
      offset: Offset.fromDirection(1),
      onSelected: (value) {
        if (value == RemindMePopupValue.pickADateAndTime) {
          showDialog(
              context: context,
              builder: (ctx) {
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
                            initialValue: DateTime.now().toString(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            icon: const Icon(Icons.event),
                            dateLabelText: 'Date',
                            timeLabelText: "Hour",
                            selectableDayPredicate: (date) {
                              date = date;
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) {
                              date = DateTime.parse(val);
                              print(DateFormat.Hms().format(date!));
                            },
                            validator: (val) {
                              // print(val);
                              return null;
                            },
                            onSaved: (val) => print(
                              DateFormat.jm().format(date!),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: TaskDetailsOptionWidget(
        title:
            'Remind me ${date == null ? '' : 'at ${DateFormat.jm().format(date!)}'}',
        icon: Icons.notifications_outlined,
        subtitle: widget.isEnabled
            ? date == null
                ? null
                : formateDate(date!)
            : null,
        isEnabled: widget.isEnabled,
        color: widget.color,
      ),
    );
  }
}
