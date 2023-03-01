import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/enums.dart';
import '../../widgets/menu_item.dart';

List<PopupMenuEntry<RemindMePopupValue>> remindMePopMenuEntries(
  BuildContext context,
) {
  final date = DateTime.now();
  double width = 250;
  return [
    PopupMenuItem(
      value: RemindMePopupValue.laterToday,
      child: PopMenuItem(
        icon: Icons.av_timer_rounded,
        width: width,
        text: 'Later today(${DateFormat.jm().format(DateTime(
          date.year,
          date.month,
          date.day,
          22,
        ))})',
      ),
    ),
    PopupMenuItem(
      value: RemindMePopupValue.tomorrow,
      child: PopMenuItem(
        icon: Icons.timer,
        width: width,
        text: 'Tomorrow(${DateFormat.E().add_jm().format(DateTime(
              date.year,
              date.month,
              date.day + 1,
              21,
            ))})',
      ),
    ),
    PopupMenuItem(
      value: RemindMePopupValue.nextWeek,
      child: PopMenuItem(
        icon: Icons.access_time_rounded,
        width: width,
        text: 'Next week(${DateFormat.E().add_jm().format(DateTime(
              date.year,
              date.month,
              date.day + 7,
              21,
            ))})',
      ),
    ),
    PopupMenuItem(
      value: RemindMePopupValue.pickADateAndTime,
      child: PopMenuItem(
        icon: Icons.av_timer_rounded,
        width: width,
        text: 'Pick a date & time',
      ),
    ),
  ];
}
