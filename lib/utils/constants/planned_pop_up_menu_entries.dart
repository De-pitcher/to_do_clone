// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/enums.dart';
import '../../widgets/menu_item.dart';

List<PopupMenuEntry<PlannedMenuValue>> plannedPopMenuEntries(
  BuildContext context,
) {
  final date = DateTime.now();
  const width = 200.0;
  return [
    PopupMenuItem(
      value: PlannedMenuValue.overDue,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: const PopMenuItem(
        icon: Icons.input_outlined,
        text: 'Overdue',
        width: width,
      ),
    ),
    PopupMenuItem(
      value: PlannedMenuValue.today,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: PopMenuItem(
        icon: Icons.today_outlined,
        width: width,
        text: 'Today(${DateFormat.E().format(date)})',
      ),
    ),
    PopupMenuItem(
      value: PlannedMenuValue.tomorrow,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: PopMenuItem(
        icon: Icons.output_rounded,
        text: 'Tomorrow(${DateFormat.E().format(
          DateTime(date.year, date.month, date.day + 1),
        )})',
        width: width,
      ),
    ),
    PopupMenuItem(
      value: PlannedMenuValue.thisWeek,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: PopMenuItem(
        icon: Icons.date_range_outlined,
        text: 'This week(${date.day} - ${DateFormat.MMMd().format(
          DateTime(date.year, date.month, date.day - 7),
        )})',
        width: width,
      ),
    ),
    PopupMenuItem(
      value: PlannedMenuValue.later,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: const PopMenuItem(
        icon: Icons.task_outlined,
        width: width,
        text: 'Later',
      ),
    ),
    PopupMenuItem(
      value: PlannedMenuValue.allPlanned,
      textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
          ),
      child: const PopMenuItem(
        icon: Icons.list_alt_rounded,
        width: width,
        text: 'All planned',
      ),
    ),
  ];
}
