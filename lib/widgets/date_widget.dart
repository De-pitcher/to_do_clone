import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

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
                  onChanged!(date.toIso8601String());
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  return true;
                },
                onChanged: onChanged,
              ),
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
