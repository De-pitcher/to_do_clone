import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../enums/planned_menu_value.dart';
import '../../enums/pop_menu_value.dart';
import '../../enums/group_pop_menu_value.dart';
import '../../enums/select_pop_menu_value.dart';
import '../../widgets/menu_item.dart';

List<PopupMenuEntry<PopMenuValue>> popMenuEntries(BuildContext context) => [
      PopupMenuItem(
        value: PopMenuValue.renameList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.edit_outlined,
          text: 'Rename list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.sortBy,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.filter_list,
          text: 'Sort by',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.addShortcut,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.shortcut,
          text: 'Add shortcut to homescreen',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.changeTheme,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.settings_display_sharp,
          text: 'Change theme',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.sendCopy,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.share,
          text: 'Send a copy',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.duplicateList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.copy,
          text: 'Duplicate list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.printList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.print_outlined,
          text: 'Print list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.deleteList,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.delete_forever_outlined,
          text: 'Delete list',
        ),
      ),
      PopupMenuItem(
        value: PopMenuValue.turnOnSuggestion,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.lightbulb_outlined,
          text: 'Turn on suggestions',
        ),
      ),
    ];

List<PopupMenuEntry<GroupPopMenuValue>> groupPopMenuEntries(
  BuildContext context,
  bool isEmpty,
) =>
    [
      PopupMenuItem(
        value: GroupPopMenuValue.addOrRemove,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.list,
          text: 'Add/Remove lists',
        ),
      ),
      PopupMenuItem(
        value: GroupPopMenuValue.renameGroup,
        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
        child: const PopMenuItem(
          icon: Icons.task_sharp,
          text: 'Rename group',
        ),
      ),
      isEmpty
          ? PopupMenuItem(
              value: GroupPopMenuValue.deleteGroup,
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
              child: const PopMenuItem(
                icon: Icons.delete,
                text: 'Delete group',
              ),
            )
          : PopupMenuItem(
              value: GroupPopMenuValue.ungroup,
              textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
              child: const PopMenuItem(
                icon: Icons.task_outlined,
                text: 'Ungroup list',
              ),
            ),
    ];

List<PopupMenuEntry<SelectPopMenuValue>> selectPopMenuEntries(
  BuildContext context,
  bool displayMarkAsImport,
  bool clearAll,
) =>
    [
      clearAll
          ? const PopupMenuItem(
              value: SelectPopMenuValue.clearAll,
              child: Text('Clear all                       '),
            )
          : const PopupMenuItem(
              value: SelectPopMenuValue.selectAll,
              child: Text('Select all                       '),
            ),
      if (!displayMarkAsImport)
        const PopupMenuItem(
          value: SelectPopMenuValue.markAsImportant,
          child: Text('Mark as important'),
        ),
      const PopupMenuItem(
        value: SelectPopMenuValue.move,
        child: Text('Move'),
      ),
      const PopupMenuItem(
        value: SelectPopMenuValue.copy,
        child: Text('Copy'),
      ),
      const PopupMenuItem(
        value: SelectPopMenuValue.deleteTask,
        child: Text('Delete task'),
      ),
    ];

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
