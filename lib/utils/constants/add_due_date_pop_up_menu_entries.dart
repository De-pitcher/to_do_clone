import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/add_due_date_pop_up_value.dart';
import '../../widgets/menu_item.dart';

double width = 250;
final date = DateTime.now();

List<PopupMenuEntry<AddDueDatePopupValue>> addDueDatePopMenuEntries() => [
      PopupMenuItem(
        value: AddDueDatePopupValue.today,
        child: PopMenuItem(
          icon: Icons.today_outlined,
          width: width,
          text: 'Today (${DateFormat.EEEE().format(DateTime(
            date.year,
            date.month,
            date.day,
            22,
          ))})',
        ),
      ),
      PopupMenuItem(
        value: AddDueDatePopupValue.tomorrow,
        child: PopMenuItem(
          icon: Icons.output_rounded,
          width: width,
          text: 'Tomorrow (${DateFormat.EEEE().format(DateTime(
            date.year,
            date.month,
            date.day + 1,
            21,
          ))})',
        ),
      ),
      PopupMenuItem(
        value: AddDueDatePopupValue.nextWeek,
        child: PopMenuItem(
          icon: Icons.date_range,
          width: width,
          text: 'Next week (${DateFormat.EEEE().format(DateTime(
            date.year,
            date.month,
            date.day + 7,
            21,
          ))})',
        ),
      ),
      PopupMenuItem(
        value: AddDueDatePopupValue.pickADate,
        child: PopMenuItem(
          icon: Icons.today,
          width: width,
          text: 'Pick a date',
        ),
      ),
    ];
