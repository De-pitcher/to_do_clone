import 'package:flutter/material.dart';

import '../../models/pop_menu_value.dart';
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
