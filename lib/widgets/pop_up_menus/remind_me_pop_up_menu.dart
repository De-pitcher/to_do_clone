import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../enums/enums.dart';
import '../../utils/constants/constants.dart';
import '../task_detail_option_widget.dart';

class RemindMePopupMenu extends StatelessWidget {
  final bool isEnabled;
  final Color color;
  const RemindMePopupMenu({
    super.key,
    required this.isEnabled,
    required this.color,
  });

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
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }

                              return true;
                            },
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                        ),
                        Align(
                          // alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: TaskDetailsOptionWidget(
        option: 'Remind me',
        icon: Icons.notifications_outlined,
        isEnabled: isEnabled,
        color: color,
      ),
    );
  }
}
